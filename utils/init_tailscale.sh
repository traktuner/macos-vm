#!/bin/bash -e -o pipefail

TAILSCALE_TOKEN=$1

echo Start Tailscale...
#start tailscaled
sudo tailscaled &

#configure tailscale and start it
sudo tailscale up --authkey=$TAILSCALE_TOKEN --hostname=macos-github