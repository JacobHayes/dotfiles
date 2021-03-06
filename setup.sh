#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if ! hash brew 2>/dev/null; then
    echo "Installing homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing brew and cask packages"
brew bundle --file=requirements/Brewfile

echo "Updating pip"
pip2 install --upgrade pip setuptools
pip3 install --upgrade pip setuptools
echo "Installing python packages"
pip2 install --upgrade -r ./requirements/python-requirements.txt
pip3 install --upgrade -r ./requirements/python-requirements.txt


echo "Linking dotfiles to ~/"
# Using the gnu version of cp from brew coreutils b/c it has the -s flag for symbolic links and works with directories
gcp -srf "${PWD}"/dotfiles/.[^.]* ~/

echo "Installing TmuxPluginManager"
test -d ~/.tmux/plugins/tpm || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Start tmux and run 'prefix-I' to install tmux plugins... Press enter when done..."
read -r

echo "Changing default shell to brew's fish"
sudo sh -c "echo '/usr/local/bin/fish' >> /etc/shells"
chsh -s /usr/local/bin/fish

if hash gcloud 2>/dev/null; then
    echo 'y' | gcloud components install docker-credential-gcr
    PATH="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin:${PATH}"
    docker-credential-gcr configure-docker
fi

./macos_settings.sh

echo "Done!"
