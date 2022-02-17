#!/bin/bash -e -o pipefail

#create_user.sh VNC_USER VNC_USER_PASSWORD

USER=$1
PASS=$2


echo Creating user $USER...
sudo dscl . -create "/Users/$USER"
sudo dscl . -create "/Users/$USER" UserShell /bin/bash
sudo dscl . -create "/Users/$USER" RealName "$USER"
sudo dscl . -create "/Users/$USER" UniqueID 1001
sudo dscl . -create "/Users/$USER" PrimaryGroupID 80
sudo dscl . -create "/Users/$USER" NFSHomeDirectory "/Users/$USER"
sudo dscl . -passwd "/Users/$USER" "$PASS"
sudo dscl . -append /Groups/admin GroupMembership "$USER"
sudo dscl . -append /Groups/wheel GroupMembership "$USER"
sudo mkdir -p "/Users/$USER"

sudo touch /var/db/.AppleSetupDone

# From https://derflounder.wordpress.com/2014/10/16/disabling-the-icloud-and-diagnostics-pop-up-windows-in-yosemite/

# Determine OS version
osvers=$(sw_vers -productVersion | awk -F. '{print $2}')
sw_vers=$(sw_vers -productVersion)

# Determine OS build number

sw_build=$(sw_vers -buildVersion)

# Checks first to see if the Mac is running 10.7.0 or higher. 
# If so, the script checks the system default user template
# for the presence of the Library/Preferences directory. Once
# found, the iCloud and Diagnostic pop-up settings are set 
# to be disabled.
echo Disabling Setup Assistant...
if [[ ${osvers} -ge 7 ]]; then
  for USER_TEMPLATE in "/System/Library/User Template"/*
  do
    if [ ! -d "$USER_TEMPLATE" ]
    then
      continue
    fi

    sudo /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool TRUE
    sudo /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant DidSeeAppearanceSetup -bool TRUE
    sudo /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant DidSeePrivacy -bool TRUE
    sudo /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant DidSeeScreenTime -bool TRUE
    sudo /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant DidSeeSiriSetup -bool TRUE
    sudo /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant DidSeeiCloudLoginForStorageServices -bool TRUE

    sudo /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant ShowKeychainSyncBuddyAtLogin -bool FALSE
    sudo /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant RunNonInteractive -bool TRUE

    sudo /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant GestureMovieSeen none
    sudo /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion "${sw_vers}"
    sudo /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant LastSeenBuddyBuildVersion "${sw_build}"      
  done
  
  # Checks first to see if the Mac is running 10.7.0 or higher.
  # If so, the script checks the existing user folders in /Users
  # for the presence of the Library/Preferences directory.
  #
  # If the directory is not found, it is created and then the
  # iCloud and Diagnostic pop-up settings are set to be disabled.

  for USER_HOME in /Users/*
  do
    USER_UID="$(basename "${USER_HOME}")"
    if [ ! "${USER_UID}" = "Shared" ]; then

      # Opening a terminal throws otherwise, as it tries to `touch` 
      # a file inside this directory
      sudo /bin/mkdir -p "${USER_HOME}"/.bash_sessions
      sudo /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/.bash_sessions

      if [ ! -d "${USER_HOME}"/Library/Preferences ]; then
        sudo /bin/mkdir -p "${USER_HOME}"/Library/Preferences
        sudo /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library
        sudo /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library/Preferences
      fi
      if [ -d "${USER_HOME}"/Library/Preferences ]; then
        sudo /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool TRUE
        sudo /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant DidSeeAppearanceSetup -bool TRUE
        sudo /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant DidSeePrivacy -bool TRUE
        sudo /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant DidSeeScreenTime -bool TRUE
        sudo /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant DidSeeSiriSetup -bool TRUE
        sudo /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant DidSeeiCloudLoginForStorageServices -bool TRUE

        sudo /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant ShowKeychainSyncBuddyAtLogin -bool FALSE
        sudo /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant RunNonInteractive -bool TRUE

        sudo /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant GestureMovieSeen none
        sudo /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion "${sw_vers}"
        sudo /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant LastSeenBuddyBuildVersion "${sw_build}"
        sudo /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant.plist
      fi
    fi
  done
fi

# See https://www.intego.com/mac-security-blog/create-a-non-login-keychain/
#su - "$USER" -c "security create-keychain -p "$USER" login"
