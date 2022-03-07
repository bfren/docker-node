#!/bin/sh

IMAGE=`cat VERSION`
NODE=${1:-17}

git pull || exit 1
chmod +x run.sh

docker buildx build \
    --build-arg BF_IMAGE=node \
    --build-arg BF_VERSION=${IMAGE} \
    -f ${NODE}/Dockerfile \
    -t node${NODE}-dev \
    . \
    && \
    docker run -it node${NODE}-dev sh
