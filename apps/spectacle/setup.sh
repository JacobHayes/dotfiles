#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

HERE="$(cd "$(dirname "$0")" ; pwd -P)"

mkdir -p "${HOME}/Library/Application Support/Spectacle"
ln -fs "${HERE}/shortcuts.json" "${HOME}/Library/Application Support/Spectacle/Shortcuts.json"

open /Applications/Spectacle.app
echo "Allow Spectacle accessability settings, then press enter to continue."
read -r
