#!/bin/bash -e -o pipefail

USER="runner"

echo Customize Safari...
SAFARI_PREFERENCES_FILE="/Users/"$USER"/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari.plist"
# safari opens with: a new window
sudo defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -bool false
# new windows open with: empty page
sudo defaults write com.apple.Safari NewWindowBehavior -int 1
# new tabs open with: empty page
sudo defaults write com.apple.Safari NewTabBehavior -int 1
# set safaris home page to `about:blank` for faster loading
sudo defaults write com.apple.Safari HomePage -string "about:blank"
# open safe files after download
sudo defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
# open pages in tabs instead of windows
sudo defaults write com.apple.Safari TabCreationPolicy -int 1
# show icons in tabs
sudo defaults write com.apple.Safari ShowIconsInTabs -bool false
# don't send search queries to Apple and do not use spotlight suggestions
sudo defaults write com.apple.Safari UniversalSearchEnabled -bool false
sudo defaults write com.apple.Safari SuppressSearchSuggestions -bool true
# show safaris bookmarks bar by default
sudo defaults write com.apple.Safari ShowFavoritesBar -bool true