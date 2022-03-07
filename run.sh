#!/bin/sh

VERSION=`cat VERSION`

git pull || exit 1
chmod +x run.sh

docker buildx build \
    --build-arg BF_IMAGE=node \
    --build-arg BF_VERSION=${VERSION} \
    -f ${1:-17}/Dockerfile \
    -t node-dev \
    . \
    && \
    docker run -it node-dev sh
