#!/bin/bash

set -euo pipefail

docker pull bfren/alpine

BASE_VERSION="5.5.0"
echo "Base: ${BASE_VERSION}"

NODE_VERSIONS="16 17 18 19 20 21 22 23"
for V in ${NODE_VERSIONS} ; do

    echo "Node.js ${V}"
    ALPINE_MINOR=`cat ./${V}/ALPINE_MINOR`
    NODE_PKG=`cat ./${V}/overlay/tmp/NODE_PKG`
    URL="https://pkgs.alpinelinux.org/packages?name=${NODE_PKG}&branch=v${ALPINE_MINOR}&repo=&arch=&maintainer="

    DOCKERFILE=$(docker run \
        -v ${PWD}:/ws \
        -e BF_DEBUG=0 \
        bfren/alpine esh \
        "/ws/Dockerfile.esh" \
        BASE_VERSION=${BASE_VERSION} \
        ALPINE_EDITION=${ALPINE_MINOR} \
        NODE_MAJOR=${V}
    )

    echo "${DOCKERFILE}" > ./${V}/Dockerfile
    echo "${URL}" > ./${V}/PKG.url

done

docker system prune -f
echo "Done."
