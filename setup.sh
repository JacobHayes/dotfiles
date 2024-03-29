#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if ! hash brew 2>/dev/null; then
    echo "Installing homebrew"
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh > /tmp/install_brew.sh
    /bin/bash /tmp/install_brew.sh
    # Install Intel brew as well for Intel only packages
    arch -x86_64 /bin/bash /tmp/install_brew.sh
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
echo "Installing brew and cask packages"
brew bundle --file=requirements/Brewfile

echo "Updating pip"
pip3 install --upgrade pip setuptools
echo "Installing python packages"
pip3 install --upgrade -r ./requirements/python-requirements.txt

echo "Linking dotfiles to ~/"
# Using the gnu version of cp from brew coreutils b/c it has the -s flag for symbolic links and works with directories
gcp -srf "${PWD}"/dotfiles/.[^.]* ~/

echo "Installing TmuxPluginManager"
test -d ~/.tmux/plugins/tpm || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Start tmux and run 'prefix-I' to install tmux plugins... Press enter when done..."
read -r

echo "Changing default shell to brew's fish"
sudo sh -c "echo '/opt/homebrew/bin/fish' >> /etc/shells"
chsh -s /opt/homebrew/bin/fish

if hash gcloud 2>/dev/null; then
    PATH="/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin:${PATH}"
    docker-credential-gcloud configure-docker
    gcloud components install cloud_sql_proxy
fi

./macos_settings.sh

echo "Done!"
