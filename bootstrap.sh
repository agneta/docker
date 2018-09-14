npm config set cache /home/agneta/.cache/npm --global
npm config set package-lock false

export HOME=/home/agneta
export NAME=agneta
export USER_ID=2000
export GROUP_ID=2000

addgroup -S -g $GROUP_ID $NAME
adduser -S -u $USER_ID -G $NAME $NAME
chown -R $NAME:$NAME $HOME
