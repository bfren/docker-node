FROM bfren/alpine-s6:alpine3.13-4.0.10

ARG BF_IMAGE
ARG BF_VERSION

EXPOSE 3000

COPY ./overlay /
COPY ./15/overlay /

RUN bf-install

VOLUME [ "/app/live", "/app/publish" ]
