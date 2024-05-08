//
// Created by tony on 21/12/23.
//
/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#include <cstdio>
#include <cstdlib>
#include <random>

#include <faiss/IndexFlat.h>
#include <faiss/IndexIVFPQ.h>
#include <faiss/IndexHNSW.h>
#include <iostream>
#include <vector>
#include <cmath>
#include <sys/time.h>
#include "ConfigureMap.h"
#include <papi_config.h>
#include "ThreadPerf.hpp"
#if AMMBENCH_PAPI == 1
#include "ThreadPerfPAPI.hpp"
#endif
#include "MemTracker.h"
static size_t timeLastUs(struct timeval ts) {
    struct timeval te;
    gettimeofday(&te, NULL);
    int64_t s0, e0, s1, e1;
    s0 = ts.tv_sec;
    s1 = ts.tv_usec;
    e0 = te.tv_sec;
    e1 = te.tv_usec;
    return 1000000 * (e0 - s0) + (e1 - s1);
}
using idx_t = faiss::idx_t;
struct timeval te;
using namespace  INTELLI;
int main(int argc, char  **argv) {

    int database_size;
    INTELLI::ConfigMap inMap;

    int pqFeedStep;
    int fullRebuild;
    size_t brutalForceBuildTime=0,brutalSearchTime=0, incrementalBuildTime=0,incrementalsearchTime=0;
    int numberOfSubQuantizer=64;
    int64_t numberOfNeighbors=32;
    if(inMap.fromCArg(argc,argv)==false)
    {
        if(argc>=2)
        {
            std::string fileName="";
            fileName+=argv[1];
            if(inMap.fromFile(fileName))
            {std::cout<<"load from file "+fileName<<endl;}
        }
    }
    INTELLI::MemoryTracker mt;
    INTELLI::MemoryTracker::setActiveInstance(&mt);
    database_size=inMap.tryI64("dbSize",1000);
    pqFeedStep=inMap.tryI64("feedStep",database_size);
    fullRebuild=inMap.tryI64("fullReBuild",0);
    numberOfSubQuantizer=inMap.tryI64("numberOfSubQuantizer",4);
    numberOfNeighbors=inMap.tryI64("numberOfNeighbors",64);
    ThreadPerfPtr pef,pef2;
#if AMMBENCH_PAPI == 1
    if (inMap.tryI64("usePAPI", 1)) {
        pef = newThreadPerfPAPI(-1);
        pef2 = newThreadPerfPAPI(-1);
    } else {
        pef = newThreadPerf(-1);
        pef2= newThreadPerf(-1);
    }
#else
    pef=newThreadPerf(-1);
    pef2=newThreadPerf(-1);
#endif
    std::cout<<inMap.toString();

    int64_t query_size=inMap.tryI64("querySize",10);
    int64_t vector_dim = inMap.tryI64("vectorDim",768);
    int64_t k = inMap.tryI64("k",5);
    std::mt19937_64 gen;
    gen = std::mt19937_64(114514);
    std::uniform_real_distribution<> distrib(0,1);
    // Create database with 1000 vectors, each with 768 dimensions
    float *database_data=new float[database_size * vector_dim];
    float *query_data=new float[query_size * vector_dim];
    for (int i = 0; i < database_size; i++) {
        for (int j = 0; j < vector_dim; j++)
        {database_data[ vector_dim* i + j] = distrib(gen);}
        database_data[vector_dim * i] += i / database_size;
    }
    for (int i =database_size/2 ; i < database_size; i++) {
        for (int j = 0; j < vector_dim; j++)
        { database_data[ vector_dim* i + j] += 500.0;}
    }
    std::cout<<"generate DB data done"<<std::endl;
    for (int i = 0; i < query_size; i++) {
        for (int j = 0; j < vector_dim; j++)
        {
           int s=database_size/query_size*i;
            query_data[ vector_dim* i + j] = database_data[vector_dim* s + j];
        }
    }
    std::cout<<"generate query data done"<<std::endl;
    // generate the ground truth by flat indexing
    faiss::IndexFlat indexFlat(vector_dim); // call constructor
    printf("is_trained = %s\n", indexFlat.is_trained ? "true" : "false");
    gettimeofday(&te,NULL);
    indexFlat.add(database_size, database_data); // add vectors to the index
    brutalForceBuildTime= timeLastUs(te)/1000;
    printf("ntotal = %zd\n", indexFlat.ntotal);
    std::vector<idx_t> index_groundTruth(k*query_size);
    std::vector<float> distance_groundTruth(k*query_size);
    gettimeofday(&te,NULL);
    indexFlat.search(query_size, query_data, k, distance_groundTruth.data(), index_groundTruth.data());
    brutalSearchTime= timeLastUs(te)/1000;
    std::cout<<"ground truth is done"<<std::endl;
   /* for (int i = 0; i < 5; i++) {
        for (int j = 0; j < k; j++)
            printf("%5zd ", index_groundTruth[i * k + j]);
        printf("\n");
    }*/
    size_t flatMem=mt.getCurMem();
    size_t chunkSize=pqFeedStep;

    //faiss::IndexFlatL2 quantizer(vector_dim); // the other index
    faiss::IndexHNSWFlat indexInc(vector_dim,numberOfNeighbors);
    // Calculate the number of chunks needed
    size_t numChunks = (database_size + chunkSize - 1) / chunkSize;
    std::cout<<"incremental Raw w/o retrain, step size ="+std::to_string(pqFeedStep)+",using "+std::to_string(numChunks)+" steps"<<std::endl;
    if(fullRebuild)
    {
        std::cout<<"warnning, use the rebuild for each inseration"<<std::endl;
    }
    // Iterate over the chunks and send them
    pef->initEventsByCfg(inMap);

    pef->start();
    mt.start(0,10000);
    for (size_t i = 0; i < numChunks; ++i) {
        size_t start = i * chunkSize;
        size_t end = std::min((i + 1) * chunkSize,(size_t) database_size);
        gettimeofday(&te,NULL);
        if(i==0)
        {
            indexInc.train(end-start, &(database_data[start*vector_dim]));
        }
        indexInc.add(end-start, &(database_data[start*vector_dim]));
        incrementalBuildTime+= timeLastUs(te);
    }
    pef->end();
    auto perfCsvBuild = pef->resultToConfigMap();
    perfCsvBuild->toFile("perf_build.csv");
    incrementalBuildTime/=1000;
    std::vector<idx_t> index_pq(k*query_size);
    std::vector<float> distance_pq(k*query_size);
    gettimeofday(&te,NULL);
    pef2->initEventsByCfg(inMap);

    pef2->start();
    indexInc.search(query_size, query_data, k, distance_pq.data(), index_pq.data());
    pef2->end();
    mt.stop();
    auto perfCsvSearch = pef->resultToConfigMap();
    perfCsvSearch->toFile("perf_search.csv");
    incrementalsearchTime= timeLastUs(te)/1000;
    std::cout<<"search done, calculate the recall"<<std::endl;
    int truePositives = 0;
    int falseNegatives = 0;

    for (int i = 0; i < query_size; ++i) {
        for (int j = 0; j < k; ++j) {
            // Check if I[i * k + j] is in groundTruthIndices[i]
            if (std::find(index_groundTruth.begin() + i * k, index_groundTruth.begin() + (i + 1) * k, index_pq[i * k + j]) != index_groundTruth.begin() + (i + 1) * k) {
                truePositives++;
            } else {
                falseNegatives++;
            }
        }
    }
    double recall = static_cast<double>(truePositives) / (truePositives + falseNegatives);
   INTELLI::ConfigMap cfg;
   cfg.edit("recall",(double )recall);
   cfg.edit("brutalForceBuild",(uint64_t)brutalForceBuildTime);
   cfg.edit("brutalForceSearch",(uint64_t)brutalSearchTime);
   cfg.edit("incrementalBuild",(uint64_t)incrementalBuildTime);
   cfg.edit("incrementalSearch",(uint64_t)incrementalsearchTime);
   cfg.edit("feedStep",(uint64_t)pqFeedStep);
   cfg.edit("retrainMode",(uint64_t)fullRebuild);
   cfg.edit("memMax",(uint64_t)mt.getMaxMem()-flatMem);
   cfg.edit("memAvg",(uint64_t)mt.getAvgMem()-flatMem);
   cfg.toFile("result.csv");
   std::cout<<cfg.toString();
   std::cout<<"mem usage by flat="+std::to_string(flatMem)+"K"<<std::endl;
   delete[] database_data;
   delete[] query_data;
    return 0;
}
