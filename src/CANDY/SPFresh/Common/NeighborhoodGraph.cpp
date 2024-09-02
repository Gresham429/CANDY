// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

#include "CANDY/SPFresh/Common/NeighborhoodGraph.h"
#include "CANDY/SPFresh/Common/KNearestNeighborhoodGraph.h"
#include "CANDY/SPFresh/Common/RelativeNeighborhoodGraph.h"

using namespace SPTAG::COMMON;

std::shared_ptr<NeighborhoodGraph> NeighborhoodGraph::CreateInstance(std::string type)
{
    std::shared_ptr<NeighborhoodGraph> res;
    if (type == "RNG")
    {
        res.reset(new RelativeNeighborhoodGraph);
    }
    else if (type == "NNG") 
    {
        res.reset(new KNearestNeighborhoodGraph);
    }
    return res;
}