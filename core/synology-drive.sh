#!/bin/bash -e -o pipefail
 
echo "Installing Synology Drive..."
brew tap homebrew/cask-drivers
brew install --cask synology-drive
while ! pgrep -f "cloud-drive-ui" > /dev/null; do
    sleep 1
done
sudo killall "cloud-drive-ui"