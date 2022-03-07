FROM bfren/alpine-s6:alpine3.15-4.1.1

ARG BF_IMAGE
ARG BF_VERSION

EXPOSE 3000

COPY ./overlay /
COPY ./17/overlay /

RUN bf-install

VOLUME [ "/app/live" ]
