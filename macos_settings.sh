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

# Install fonts
open Inconsolata/Inconsolata-Bold.ttf
open Inconsolata/Inconsolata-Regular.ttf
# Setup apps
for app in ./apps/*/; do
    "${app}"/setup.sh
done
# Set preferred macOS and app settings. Probably worth looking at what the defaults are from the new computer so we can
# drop them here.
#
# Set dark mode
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to 1'
# Turn on firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
# This is handy to allow new applications through:
#     sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add /path/to/file
#
# pmset -g custom
    # Battery Power:
    #  lidwake              1
    #  autopoweroff         1
    #  standbydelayhigh     86400
    #  autopoweroffdelay    28800
    #  standbydelaylow      10800
    #  standby              1
    #  proximitywake        0
    #  hibernatemode        3
    #  powernap             0
    #  gpuswitch            2
    #  hibernatefile        /var/vm/sleepimage
    #  ttyskeepawake        1
    #  highstandbythreshold 50
    #  displaysleep         2
    #  sleep                1
    #  lessbright           1
    #  halfdim              1
    #  acwake               0
    #  tcpkeepalive         1
    #  disksleep            10
    # AC Power:
    #  lidwake              1
    #  autopoweroff         1
    #  standbydelayhigh     86400
    #  autopoweroffdelay    28800
    #  proximitywake        1
    #  standby              1
    #  standbydelaylow      10800
    #  ttyskeepawake        1
    #  hibernatemode        3
    #  powernap             1
    #  gpuswitch            2
    #  hibernatefile        /var/vm/sleepimage
    #  highstandbythreshold 50
    #  womp                 1
    #  displaysleep         10
    #  networkoversleep     0
    #  sleep                1
    #  tcpkeepalive         1
    #  halfdim              1
    #  acwake               0
    #  disksleep            10
#
# sudo systemsetup -getsleep
    # Sleep: Computer sleeps after 1 minutes
    # Sleep: Display sleeps after 10 minutes
    # Sleep: Disk sleeps after 10 minutes
# sudo systemsetup -getcomputername
    # Computer Name: JacobHayes
# sudo systemsetup -getlocalsubnetname
    # Local Subnet Name: JacobHayes
# defaults read com.apple.AppleMultitouchTrackpad
    # ActuateDetents = 1;
    # Clicking = 0;
    # DragLock = 0;
    # Dragging = 0;
    # FirstClickThreshold = 1;
    # ForceSuppressed = 0;
    # SecondClickThreshold = 1;
    # TrackpadCornerSecondaryClick = 0;
    # TrackpadFiveFingerPinchGesture = 2;
    # TrackpadFourFingerHorizSwipeGesture = 2;
    # TrackpadFourFingerPinchGesture = 2;
    # TrackpadFourFingerVertSwipeGesture = 2;
    # TrackpadHandResting = 1;
    # TrackpadHorizScroll = 1;
    # TrackpadMomentumScroll = 1;
    # TrackpadPinch = 1;
    # TrackpadRightClick = 1;
    # TrackpadRotate = 1;
    # TrackpadScroll = 1;
    # TrackpadThreeFingerDrag = 0;
    # TrackpadThreeFingerHorizSwipeGesture = 2;
    # TrackpadThreeFingerTapGesture = 0;
    # TrackpadThreeFingerVertSwipeGesture = 2;
    # TrackpadTwoFingerDoubleTapGesture = 1;
    # TrackpadTwoFingerFromRightEdgeSwipeGesture = 3;


# Set network name
sudo scutil --set HostName JacobHayes
sudo scutil --set LocalHostName JacobHayes
sudo scutil --set ComputerName JacobHayes
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "JacobHayes"
# '-g' is short for the 'NSGlobalDomain' domain
defaults delete -g NSUserDictionaryReplacementItems
defaults write -g AppleActionOnDoubleClick -string 'Maximize'
defaults write -g AppleFirstWeekday -dict 'gregorian' -int 2
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
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSWindowResizeTime -float 0.0
defaults write -g com.apple.springing.delay -float 0.5
defaults write -g com.apple.trackpad.scaling -float 1.5
# Airdrop
defaults write com.apple.NetworkBrowser DisableAirDrop -bool YES
# Filevault
echo "Double check filevault is setup..."
sudo fdesetup enable
# Update checks
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
# Dashboard
defaults write com.apple.dashboard dashboard-enabled-state -int 1 # Disabled
  # defaults write com.apple.dashboard mcx-disabled -bool true
# Dock
defaults delete com.apple.dock persistent-apps # Add things manually
defaults delete com.apple.dock persistent-others # Add things manually
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock largesize -float 50
defaults write com.apple.dock expose-group-apps -bool true
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock mineffect -string 'scale'
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock pinning -string 'middle'
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
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.bluetooth" -bool true
defaults write com.apple.systemuiserver menuExtras -array \
    "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
    "/System/Library/CoreServices/Menu Extras/Battery.menu" \
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
    "/System/Library/CoreServices/Menu Extras/Clock.menu" \
    "/System/Library/CoreServices/Menu Extras/User.menu" \
    "/System/Library/CoreServices/Menu Extras/Volume.menu"
# Accessability - aka zoom and invert
defaults write com.apple.universalaccess closeViewDesiredZoomFactor -float 2
defaults write com.apple.universalaccess closeViewFlashScreenOnNotificationEnabled -bool true
# Spaces
defaults write com.apple.spaces spans-displays -bool false
# Postico
defaults write at.eggerapps.Postico ShowSidebar -bool true
defaults write at.eggerapps.Postico PreferTableListView -bool true

for app in "Dock" "Finder"; do
  killall "${app}" > /dev/null 2>&1
done

echo "Don't forget to:"
# Seems to affect ~/Library/Preferences/ByHost/.GlobalPreferences.C5F35112-9928-5C38-9795-089536A743A2.plist
# obviously has a few difficult to figure out values
echo "- disable caps-lock. Open Keyboard prefs->Modifier Keys, Caps-lock no action"
echo "- set ctrl-cmd-space to zoom, ctrl-option-cmd-space to invert"
echo "- disable guest account"
echo "- replace Spotlight shortcut with Alfred (remove system shortcut and open Alfred and set it there)"
echo ""
echo "Waiting..."
read -r
