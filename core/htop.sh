#!/bin/bash -e -o pipefail
source ./utils/utils.sh
 
echo "Installing htop..."
brew_smart_install "htop"