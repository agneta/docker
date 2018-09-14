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

RUN npm config set cache /home/agneta/.cache/npm --global && \
    npm config set package-lock false && \
    export HOME=/home/agneta && \
    export USER=agneta && \
    export USER_ID=501 && \
    export GROUP_ID=20 && \
    USER_ID=${USER_ID:-9001} && \
    GROUP_ID=${GROUP_ID:-9001} && \
    deluser --remove-home node && \
    addgroup -S -g $GROUP_ID $USER && \
    adduser -S -u $USER_ID -G $USER $USER && \
    chown -R $USER:$USER $HOME

USER agneta
