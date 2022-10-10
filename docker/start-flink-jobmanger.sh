#!/bin/env bash

#component=$1

docker network inspect flink-network  >/dev/null 2>&1 || \
    docker network create flink-network 


FLINK_PROPERTIES="jobmanager.rpc.address: jobmanager"

docker run \
    --rm \
    --network flink-network \
    --name jobmanager \
    --publish 8081:8081 \
    --env FLINK_PROPERTIES="${FLINK_PROPERTIES}" \
    flink:1.15.1-scala_2.12 jobmanager 
