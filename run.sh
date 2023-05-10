#!/bin/sh

IMAGE=`cat VERSION`
NODE=${1:-20}

docker buildx build \
    --build-arg BF_IMAGE=node \
    --build-arg BF_VERSION=${IMAGE} \
    -f ${NODE}/Dockerfile \
    -t node${NODE}-dev \
    . \
    && \
    docker run -it node${NODE}-dev sh
