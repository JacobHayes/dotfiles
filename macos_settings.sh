#!/usr/bin/env bash
#
# Take a look at these for other ideas:
# https://github.com/dsdstudio/dotfiles/blob/master/.osx
# https://github.com/mathiasbynens/dotfiles/blob/master/.macos
# https://gist.github.com/meleyal/5890865
# https://github.com/connorcimowsky/dotfiles/blob/master/defaults.sh
# https://www.defaults-write.com/speed-up-macos-high-sierra/
# https://github.com/herrbischoff/awesome-osx-command-line
# https://gist.github.com/ryanpcmcquen/b2e608311f286a4ab3e1

set -o errexit
set -o nounset
set -o pipefail

osascript -e 'tell application "System Preferences" to quit'

# Add settings for "Require admin password for system settings" from Sec&Privacy->Advanced

echo "A" | softwareupdate --install-rosetta

# Install fonts
open Inconsolata/Inconsolata-Bold.ttf
open Inconsolata/Inconsolata-Regular.ttf
echo "Install the fonts and press enter."
read -r
# Setup apps
for app in ./apps/*/; do
    "${app}"/setup.sh
done

# Set preferred macOS and app settings. Probably worth looking at what the defaults are from the new computer so we can
# drop them here.
#
# Set dark mode
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to 1'
# Set network name
sudo scutil --set HostName JacobHayes
sudo scutil --set LocalHostName JacobHayes
sudo scutil --set ComputerName JacobHayes
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "JacobHayes"
# '-g' is short for the 'NSGlobalDomain' domain
defaults delete -g NSUserDictionaryReplacementItems || true
defaults write -g AppleActionOnDoubleClick -string 'Maximize'
defaults write -g AppleFirstWeekday -dict 'gregorian' -int 2
defaults write -g AppleICUForce24HourTime -bool true
defaults write -g AppleInterfaceStyle -string 'Dark'
defaults write -g AppleLanguages -array -string 'en-US' -string 'es-US'
defaults write -g AppleLocale -string 'en_US'
defaults write -g AppleMeasurementUnits -string 'Centimeters'
defaults write -g AppleMetricUnits -bool true
defaults write -g ApplePressAndHoldEnabled -bool false # Allow key repeat
defaults write -g AppleScrollerPagingBehavior -bool true
defaults write -g AppleShowScrollBars -string 'WhenScrolling'
defaults write -g AppleTemperatureUnit -string 'Celsius'
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSWindowResizeTime -float 0.0
defaults write -g com.apple.springing.delay -float 0.5
defaults write -g com.apple.trackpad.scaling -float 1.5
# Update checks
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
# Dashboard
defaults write com.apple.dashboard dashboard-enabled-state -int 1 # Disabled
  # defaults write com.apple.dashboard mcx-disabled -bool true
# Dock
defaults delete com.apple.dock persistent-apps || true # Add things manually
defaults delete com.apple.dock persistent-others || true # Add things manually
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock largesize -float 50
defaults write com.apple.dock expose-group-apps -bool true
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock mineffect -string 'scale'
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock pinning -string 'middle'
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock showAppExposeGestureEnabled -bool true
defaults write com.apple.dock tilesize -float 25
# Finder
sudo chflags nohidden ~/Library
sudo chflags nohidden /Volumes
defaults write com.apple.finder AppleShowAllFiles true
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowRecentTags -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowSidebar -bool true
defaults write com.apple.finder ShowTabView -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# Battery Menubar
defaults write com.apple.menuextra.battery ShowPercent -string 'YES'
# Clock Menubar
defaults write com.apple.menuextra.clock DateFormat -string 'EEE MMM d  H:mm'
# Share menu
defaults write com.apple.preferences.extensions.ShareMenu displayOrder -array -string 'com.apple.share.AirDrop.send'
defaults write com.apple.preferences.extensions.ShareMenu userHasOrdered -bool true
# Menu bar items
defaults write com.apple.systemuiserver "NSStatusItem Visible Siri" -bool false
# TODO: This doesn't seem to actually work... it gets reset to True on SystemUIServer restart...
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.airplay" -bool false
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.bluetooth" -bool true
defaults write com.apple.systemuiserver menuExtras -array \
    "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
    "/System/Library/CoreServices/Menu Extras/Battery.menu" \
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
    "/System/Library/CoreServices/Menu Extras/Clock.menu" \
    "/System/Library/CoreServices/Menu Extras/User.menu" \
    "/System/Library/CoreServices/Menu Extras/Volume.menu"
# Accessability - aka zoom and invert
sudo defaults write com.apple.universalaccess closeViewDesiredZoomFactor -float 2
sudo defaults write com.apple.universalaccess closeViewFlashScreenOnNotificationEnabled -bool true
# Spaces
defaults write com.apple.spaces spans-displays -bool false
# Postico
defaults write at.eggerapps.Postico ShowSidebar -bool true
defaults write at.eggerapps.Postico PreferTableListView -bool true
# Disable the Guest user (still will have a sign option for Filevault/Find my Mac)
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false
# Requre admin password to access system preferences
security authorizationdb read system.preferences > /tmp/system.preferences.plist
/usr/libexec/PlistBuddy -c "Set :shared false" /tmp/system.preferences.plist
security authorizationdb write system.preferences < /tmp/system.preferences.plist
rm /tmp/system.preferences.plist
# Set keyboard remaps. Remaps are keyboard specific and use a combined identifier of the vendor and product. The
# following command can be used to detect all keyboards. It only shows attached devices, so bluetooth keyboards should
# be connected.
#   ioreg -n IOHIDInterface -r | grep -e 'class IOHIDKeyboard' -e VendorID\" -e Product
# It will print the VendorID, Product name, and ProductID. The format used for the mapping is:
#   {VendorID}-{ProductID}-{0 or # attached, if multiple}
#
# Most of this was pulled from https://apple.stackexchange.com/a/88096, but had to use IOHIDInterface instead.
#
# Mapping caps to esc for internal trackpad/keyboards:
defaults -currentHost write -g com.apple.keyboard.modifiermapping.1452-834-0 -array \
  '<dict><key>HIDKeyboardModifierMappingDst</key><integer>30064771113</integer><key>HIDKeyboardModifierMappingSrc</key><integer>30064771129</integer></dict>'
# Bluetooth Lenovo keyboard. Mapping caps to esc and swapping alt/windows buttons to match options/command
defaults -currentHost write -g com.apple.keyboard.modifiermapping.6127-24648-0 -array \
  '<dict><key>HIDKeyboardModifierMappingDst</key><integer>30064771113</integer><key>HIDKeyboardModifierMappingSrc</key><integer>30064771129</integer></dict>' \
  '<dict><key>HIDKeyboardModifierMappingDst</key><integer>30064771298</integer><key>HIDKeyboardModifierMappingSrc</key><integer>30064771303</integer></dict>' \
  '<dict><key>HIDKeyboardModifierMappingDst</key><integer>30064771299</integer><key>HIDKeyboardModifierMappingSrc</key><integer>30064771302</integer></dict>' \
  '<dict><key>HIDKeyboardModifierMappingDst</key><integer>30064771302</integer><key>HIDKeyboardModifierMappingSrc</key><integer>30064771299</integer></dict>' \
  '<dict><key>HIDKeyboardModifierMappingDst</key><integer>30064771303</integer><key>HIDKeyboardModifierMappingSrc</key><integer>30064771298</integer></dict>'
# Enable Night Shift
sudo /usr/libexec/PlistBuddy -c "Set :CBUser-$(dscl . -read "${HOME}" GeneratedUID | sed 's/GeneratedUID: //'):CBBlueReductionStatus:BlueReductionMode 1" /private/var/root/Library/Preferences/com.apple.CoreBrightness.plist
# Remove text replacements
HOST_UUID="$(ioreg -rd1 -c IOPlatformExpertDevice | grep -E '(UUID)' | awk '{print $3}' | tr -d \")"
sqlite3 "${HOME}/Library/Dictionaries/CoreDataUbiquitySupport/${USER}~${HOST_UUID}/UserDictionary/local/store/UserDictionary.db" 'delete from ZUSERDICTIONARYENTRY;'

for app in "Dock" "Finder" "SystemUIServer" "cfprefsd"; do
  killall "${app}" > /dev/null
done
for app in "corebrightnessd"; do
  sudo killall "${app}" > /dev/null
done

# Filevault
echo "Double check filevault is setup..."
# It returns error code 24 if already enabled (hopefully not for other errors...), so allow that to fail passively.
( sudo fdesetup enable >> filevault_recovery_key.txt && status=$? ) || status=$?
if [[ "${status}" != "24" ]]; then
  exit $status
fi

echo "Make sure to check out and save off filevault_recovery_key.txt. Press enter when done..."
read -r

echo "Don't forget to:"
echo "- add spectacle to login apps"
echo "- replace Spotlight shortcut with Alfred (remove system shortcut and open Alfred and set it there)"
echo "- set ctrl-cmd-space to zoom, ctrl-option-cmd-space to invert"
echo ""
echo "Press enter when done..."
read -r

echo "You'll want to restart after this just to be sure all the settings are applied."
