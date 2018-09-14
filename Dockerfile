FROM node:9-alpine

RUN apk -v --update add \
    python \
    openssh \
    build-base \
    libssh-dev \
    git \
    graphicsmagick \
    bash \
    libc6-compat \
    gawk \
    shadow \
    sed \
    grep \
    bc \
    coreutils \
    su-exec && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/* && \
    mkdir -p agneta/app

WORKDIR agneta/app

ADD bootstrap.sh /
RUN chmod 700 /bootstrap.sh && \
    /bootstrap.sh
