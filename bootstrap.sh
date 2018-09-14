npm config set cache /home/agneta/.cache/npm --global
npm config set package-lock false

export HOME=/home/agneta
export USER=agneta
export USER_ID=1000
export GROUP_ID=1000

USER_ID=${USER_ID:-9001}
GROUP_ID=${GROUP_ID:-9001}
GROUP_NAME=$(getent group $GROUP_ID | cut -d: -f1)

deluser --remove-home node
if [ -z GROUP_NAME ]
then
addgroup -S -g $GROUP_ID $USER
else
groupmod -n $USER $GROUP_NAME
fi
adduser -S -u $USER_ID -G $USER $USER
chown -R $USER:$USER $HOME