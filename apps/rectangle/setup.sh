#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

HERE="$(cd "$(dirname "$0")" ; pwd -P)"

ln -fs "${HERE}/com.knollsoft.Rectangle.plist" "${HOME}/Library/Preferences/com.knollsoft.Rectangle.plist"

open /Applications/Rectangle.app
echo "Allow Rectangle accessability settings, then press enter to continue."
read -r
