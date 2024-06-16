//
// Created by rubato on 12/6/24.
//

#ifndef DAGNN_H
#define DAGNN_H
#include <Utils/IntelliTensorOP.hpp>
#include <vector>
#include <queue>
#include <random>
#include <CANDY/DAGNNIndex/DAGNNUtil.h>
#include <faiss/IndexFlat.h>
#include <omp.h>

namespace CANDY{
/**
* @class
* @brief The dynamic parameter tuning graph that has the structure of HNSW
*/
struct DynamicTuneHNSW{
    using idx_t = int64_t;

    struct Candidate {
        idx_t id;
        float dist;
        bool operator<(const Candidate& obj1) const{
            return dist<obj1.dist;
        }
    };
    struct Node{
        idx_t id = -1;
        size_t level = -1;
        // Neighbor* neighbors;
        std::vector<idx_t> neighbors;
        std::vector<float> distances;

    };



    /// The auto-tune parameters
    struct DynamicTuneParams{
        int64_t efConstruction = 40;
        int64_t efSearch = 25;
        int64_t bottom_connections_upper_bound = 32;
        int64_t bottom_connections_lower_bound = 16;
        int64_t distance_computation_opt = 0;

        /* Number of outwards steps we define as a cluster. Suppose we have 1->2, 1->3, 3->4, 4->5
         and clusterExpansionStep = 2, then for cluster centering vertex_1, we have vertex_{1,2,3,4}
         as the cluster centering vertex_1
         */
        int64_t clusterExpansionStep = 1;
        /*
            The size of time-local window
         */
        int64_t timeWindowSize = 50;


    };

    struct GraphStats{
        float value_average = 0.0;
        float degree_average = 0.0;
        float degree_skewness = 0.0;


        ///TODO: DEFINE THIS!
        float interconnection_rates = 0.0;
        std::vector<idx_t> overclusterings;

    };

    struct GraphStates{
        GraphStats global_stat;
        GraphStats time_local_stat;

        /// others
    };
    int64_t vecDim;
    DAGNN::DistanceQueryer* disq = nullptr;

    DynamicTuneParams dynamicParams;

    // The database, only for retrieving vector using reconstruct();
    faiss::IndexFlat* storage = nullptr;
    /// The graph neighbor structure. Use linkLists[idx] to locate a Nodes' neighbor list
    std::vector<Node*> linkLists;
    std::vector<idx_t> entry_points;
    /// HNSW level assigning
    std::vector<double> assign_probs;
    /// cumulative number of neighbors stored per level
    std::vector<size_t> cum_nneighbor_per_level;
    size_t max_level = -1;




    DynamicTuneHNSW(const int64_t M, const int64_t dim, const DAGNN::dagnn_metric_t metric, const DynamicTuneParams setting) {
        vecDim = dim;
        set_default_probs(M, 1.0/log(M));
        disq = new DAGNN::DistanceQueryer(metric,dim);
        if(metric == DAGNN_METRIC_L2){
            storage = new faiss::IndexFlatL2(vecDim);
        } else {
            storage = new faiss::IndexFlatIP(vecDim);
        }
        dynamicParams = setting;
        assert(storage);
    }

    void get_vector(const idx_t i, float* x) const {
        assert(i<storage->ntotal);
        storage->reconstruct(i, x);
    }

    /// HNSW init
    /// initialize probs and cum_nb_neighbors_per_levels
    void set_default_probs(const int64_t M, const float levelMult){
        int64_t nn=0;
        cum_nneighbor_per_level.push_back(0);
        for(size_t level=0;;level++){
            double prob = exp(-level*1.0/levelMult)*(1-exp(-1/levelMult));
            if(prob < 1e-9){
                break;
            }
            assign_probs.push_back(prob);
            if(level!=0){
                nn+=M;
            } else {
                nn+=M*2;
            }
            cum_nneighbor_per_level.push_back(nn);
        }

    }

    void assign_levels(idx_t n) {
        idx_t n0 = storage->ntotal;
        std::mt19937_64 gen;
        gen = std::mt19937_64(114514);
        std::uniform_real_distribution<> distrib(0,1);

        for(idx_t i=0; i<n; i++) {
            double rand = distrib(gen);
            int64_t level = 0;
            for(level = 0; level<assign_probs.size(); level++) {
                if(rand<assign_probs[level]) {
                    break;
                }
                rand -= assign_probs[level];
            }
            if(level==assign_probs.size()) {
                level--;
            }
            if(max_level < level) {
                max_level = level;
            }
            auto new_node = new Node();
            new_node->id = n0+i;
            new_node->level = level;
            new_node->neighbors.resize(cum_nneighbor_per_level[new_node->level+1], -1);
            new_node->distances.resize(cum_nneighbor_per_level[new_node->level+1], -1);
            // use cum_nneighbor_per_level[new_node.level] to get total number of levels
            linkLists.push_back(new_node);

            printf("MY id is %ld, level is %ld, cum neighbor is %ld\n", new_node->id, new_node->level, cum_nneighbor_per_level[new_node->level+1]);
        }
    }

    /// use level+1 to get level's nb_neighbors and cum_nneighbor
    size_t nb_neighbors(const size_t layer_no) const{
        return cum_nneighbor_per_level[layer_no+1]-cum_nneighbor_per_level[layer_no];
    }


    /// Index functionalities
    // add break down into 4 parts: greedy, candidate_add, prune and link
    void add(idx_t n, const float* x);

    void greedy_top(size_t level, idx_t entry, float distance_entry, std::priority_queue<Candidate>& candidates);

    void greedy_base(size_t level, idx_t entry, float distance_entry, std::priority_queue<Candidate>& candidates);

    void candidate_add(size_t level, idx_t entry, float distance_entry, std::priority_queue<Candidate>& candidates);

    void prune(size_t level, idx_t entry, float distance_entry, std::priority_queue<Candidate>& candidates);

    void link(size_t level, idx_t entry, std::priority_queue<Candidate>& candidates);


    void search(idx_t n, const float* x, idx_t annk, idx_t* results, float* distances);

    void candidate_search(idx_t entry, std::priority_queue<Candidate>& candidates);

    /// Dynamic tune specific
    bool updateParams(const DynamicTuneParams& dp){
        dynamicParams = dp;
        return true;
    }

    bool performAction(const size_t action_num){
        return true;
    }

    /// Dynamic Actions




};

/**
* @class DynamicTuneGraph
* @brief The dynamic parameter tuning graph that has only one level
*/
struct DynamicTunePlate : public DynamicTuneHNSW{





};


}

#endif //DAGNN_H
