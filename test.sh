#!/bin/sh

IMAGE=node
VERSION=`cat VERSION`
NODE=${1:-22}
TAG=${IMAGE}-test

docker buildx build \
    --load \
    --build-arg BF_IMAGE=${IMAGE} \
    --build-arg BF_VERSION=${VERSION} \
    -f ${NODE}/Dockerfile \
    -t ${TAG} \
    . \
    && \
    docker run --entrypoint /test ${TAG}
