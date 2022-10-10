#!/bin/env bash

#component=$1

docker network inspect flink-network  >/dev/null 2>&1 || \
    docker network create flink-network 


FLINK_PROPERTIES="jobmanager.rpc.address: jobmanager"

docker run \
    --rm \
    --network flink-network \
    --env FLINK_PROPERTIES="${FLINK_PROPERTIES}" \
    flink:1.15.1-scala_2.12 taskmanager 
