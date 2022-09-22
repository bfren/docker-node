FROM bfren/alpine-s6:alpine3.16-4.3.12

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-node"

ARG BF_IMAGE
ARG BF_VERSION

ENV \
    # the port to attach the Node.js server to
    NODE_PORT=3000

EXPOSE ${NODE_PORT}

COPY ./overlay /
COPY ./18/overlay /

RUN bf-install

VOLUME [ "/app/live" ]
