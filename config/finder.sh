#!/bin/bash -e -o pipefail

USER="runner"

echo Customize Finder...
sudo mysides remove "Desktop"
PATH_TO_SYSTEM_APPS="/System/Applications"
PATH_TO_APPS="/System/Volumes/Data/Applications"
sudo mysides add Utilities file://"$PATH_TO_APPS/Utilities"
sudo mysides add Applications file://"$PATH_TO_APPS"
sudo mysides add "$USER" file:///Users/"$USER"

# do not show icloud drive in sidebar
sudo defaults write com.apple.finder SidebarShowingiCloudDesktop -bool false
sudo defaults write com.apple.finder SidebarShowingSignedIntoiCloud -bool false
#don't show tags
sudo defaults write com.apple.finder ShowRecentTags -bool false
# restarting finder
sudo killall cfprefsd
sudo killall Finder