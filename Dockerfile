FROM node:8-alpine
ENV NPM_CONFIG_PREFIX=/home/agneta/.npm-global

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

USER agneta

RUN npm config set cache /home/agneta/.cache/npm --global && \
    npm config set package-lock false && \
    npm install --global --prefer-offline agneta-cli && \
    npm install --prefer-offline --no-shrinkwrap --loglevel info agneta-platform


