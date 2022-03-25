#!/bin/bash

set -euo pipefail

docker pull bfren/alpine

BASE_REVISION="4.2.3"
echo "Base: ${BASE_REVISION}"

NODE_VERSIONS="14 16 17"
for V in ${NODE_VERSIONS} ; do

    echo "Node.js ${V}"
    ALPINE_MINOR=`cat ./${V}/ALPINE_MINOR`

    DOCKERFILE=$(docker run \
        -v ${PWD}:/ws \
        -e BF_DEBUG=0 \
        bfren/alpine esh \
        "/ws/Dockerfile.esh" \
        BASE_REVISION=${BASE_REVISION} \
        ALPINE_MINOR=${ALPINE_MINOR} \
        NODE_MAJOR=${V}
    )

    echo "${DOCKERFILE}" > ./${V}/Dockerfile

done

docker system prune -f
echo "Done."
