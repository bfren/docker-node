FROM ghcr.io/bfren/alpine-s6:alpine3.20-5.6.2

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-node"

ARG BF_IMAGE
ARG BF_PUBLISHING
ARG BF_VERSION

EXPOSE 3000

COPY ./overlay /
COPY ./21/overlay /

RUN bf-install

VOLUME [ "/app/live" ]
