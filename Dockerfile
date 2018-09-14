FROM node:8-alpine

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
    mkdir -p /home/agneta/app

WORKDIR /home/agneta/app

ADD bootstrap.sh /
RUN chmod 700 /bootstrap.sh && \
    /bootstrap.sh
USER agneta

ENV NPM_CONFIG_PREFIX=/home/agneta/.npm-global
ENV NODE_ENV=production

RUN npm config set cache /home/agneta/.cache/npm --global && \
    npm config set cache-min 9999999 && \
    npm install --global agneta-cli && \
    npm install agneta-platform && \
    rm -r /home/agneta/app/* 


