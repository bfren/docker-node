FROM bfren/alpine-s6:alpine3.15-4.0.10

ARG BF_IMAGE
ARG BF_VERSION

EXPOSE 3000

COPY ./overlay /
COPY ./16/overlay /

RUN bf-install

VOLUME [ "/app/live" ]
