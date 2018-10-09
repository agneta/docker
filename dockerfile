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
    sed \
    grep \
    bc \
    coreutils \
    su-exec && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/* && \
    mkdir -p /home/agneta/app

WORKDIR /home/agneta/app

RUN npm install --global --prefer-offline agneta-cli@0.12.6 && \
    npm config set cache /home/agneta/.cache/npm --global && \
    npm config set package-lock false && \
    export HOME=/home/agneta && \
    export USER=agneta && \
    export USER_ID=1000 && \
    export GROUP_ID=1000 && \
    USER_ID=${USER_ID:-9001} && \
    GROUP_ID=${GROUP_ID:-9001} && \
    deluser --remove-home node && \
    addgroup -S -g $GROUP_ID $USER && \
    adduser -S -u $USER_ID -G $USER $USER && \
    chown -R $USER:$USER $HOME

USER agneta
RUN npm install agneta-platform@0.15.17 --prefer-offline --no-shrinkwrap --loglevel info
