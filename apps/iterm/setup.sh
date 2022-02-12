#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

open /Applications/iTerm.app
sleep 1

HERE="$(cd "$(dirname "$0")" ; pwd -P)"

mkdir -p "${HOME}/Library/Application Support/iTerm2/DynamicProfiles"
# Add custom profiles
ln -fs "${HERE}/profiles.json" "${HOME}/Library/Application Support/iTerm2/DynamicProfiles/profiles.json"
# Delete the default profiles
defaults delete com.googlecode.iterm2 "New Bookmarks"
# Set the 'dark' theme as the default
defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "DARKZZZZ-51BB-4654-9E04-B6876D3A57E5"
# Generic display tweaks
defaults write com.googlecode.iterm2 AdjustWindowForFontSizeChange -bool false
defaults write com.googlecode.iterm2 AllowClipboardAccess -bool True # Allow cli apps to touch system clipboard
defaults write com.googlecode.iterm2 EnableDivisionView -bool false # Don't show line under status bar
defaults write com.googlecode.iterm2 QuitWhenAllWindowsClosed -bool True # Quit iterm
defaults write com.googlecode.iterm2 UseBorder -bool true # Fill gap from fixed-width font
defaults write com.googlecode.iterm2 WindowNumber -bool False # Remove window number from title
# Enable automatic updates and set to beta channel
defaults write com.googlecode.iterm2 CheckTestRelease -bool true
defaults write com.googlecode.iterm2 SUAutomaticallyUpdate -bool true
defaults write com.googlecode.iterm2 SUEnableAutomaticChecks -bool true
defaults write com.googlecode.iterm2 SUFeedURL -string "https://iterm2.com/appcasts/testing.xml?shard=22"
# Enable support for programmatic control from python
defaults write com.googlecode.iterm2 EnableAPIServer -bool true
