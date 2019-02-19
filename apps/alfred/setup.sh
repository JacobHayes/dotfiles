#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

mkdir -p "${HOME}/Library/Application Support/Alfred 3"
ln -fs "${PWD}/Alfred.alfredpreferences" "${HOME}/Library/Application Support/Alfred 3/Alfred.alfredpreferences"
