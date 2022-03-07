FROM bfren/alpine-s6:alpine3.15-4.0.10

ARG BF_IMAGE
ARG BF_VERSION

EXPOSE 3000

COPY ./overlay /
COPY ./16/NODE_BUILD /tmp/
COPY ./16/YARN_BUILD /tmp/

RUN bf-install

VOLUME [ "/app/live", "/app/publish" ]
