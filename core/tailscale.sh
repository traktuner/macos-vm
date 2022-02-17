#!/bin/bash -e -o pipefail
source ./utils/utils.sh
 
echo "Installing tailscale..."
brew_smart_install "tailscale"