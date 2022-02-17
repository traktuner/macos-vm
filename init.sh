#!/bin/bash -e -o pipefail

#init.sh $VNC_USER" "$VNC_PASSWORD" "$VNC_USER_PASSWORD" "$TAILSCALE_TOKEN"

VNC_USER=$1
VNC_PASSWORD=$2
VNC_USER_PASSWORD=$3
TAILSCALE_TOKEN=$4

#fix permissions
sudo chmod -R 777 ./*

./utils/create_user.sh "$VNC_USER" "$VNC_USER_PASSWORD"
./utils/install_apps.sh
./utils/configure.sh "$VNC_PASSWORD"
./utils/init_tailscale.sh "$TAILSCALE_TOKEN"