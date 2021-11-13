#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

HERE="$(cd "$(dirname "$0")" ; pwd -P)"

mkdir -p "${HOME}/Library/Application Support/Alfred/Alfred.alfredpreferences/"
# Ignore the "remote" preferences
ln -fs "${HERE}/preferences" "${HOME}/Library/Application Support/Alfred/Alfred.alfredpreferences/"
