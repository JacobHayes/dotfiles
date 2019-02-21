#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

HERE="$(cd "$(dirname "$0")" ; pwd -P)"

mkdir -p "${HOME}/Library/Application Support/Alfred 3"
ln -fs "${HERE}/Alfred.alfredpreferences" "${HOME}/Library/Application Support/Alfred 3/"
