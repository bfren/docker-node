FROM bfren/alpine-s6:alpine3.16-4.3.9

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-node"

ARG BF_IMAGE
ARG BF_VERSION

EXPOSE 3000

COPY ./overlay /
COPY ./18/overlay /

RUN bf-install

VOLUME [ "/app/live" ]
