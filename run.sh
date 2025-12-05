#!/bin/sh

IMAGE=`cat VERSION`
NODE=${1:-24}

docker buildx build \
    --load \
    --progress plain \
    --build-arg BF_IMAGE=node \
    --build-arg BF_VERSION=${IMAGE} \
    -f ${NODE}/Dockerfile \
    -t node${NODE}-dev \
    . \
    && \
    docker run -it -e BF_DEBUG=1 node${NODE}-dev sh
