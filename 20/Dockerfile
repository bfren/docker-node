FROM bfren/alpine-s6:alpine3.19-5.2.3

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-node"

ARG BF_IMAGE
ARG BF_PUBLISHING
ARG BF_VERSION

EXPOSE 3000

COPY ./overlay /
COPY ./20/overlay /

RUN bf-install

VOLUME [ "/app/live" ]
