#!/bin/bash

set -euo pipefail

docker pull bfren/alpine

BASE_REVISION="5.0.0-dev"
echo "Base: ${BASE_REVISION}"

NODE_VERSIONS="16 17 18 19 20"
for V in ${NODE_VERSIONS} ; do

    echo "Node.js ${V}"
    ALPINE_MINOR=`cat ./${V}/ALPINE_MINOR`

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

done

docker system prune -f
echo "Done."
