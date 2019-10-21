# Set a clean default PATH
set PATH /usr/local/bin /usr/bin /bin /usr/local/sbin /usr/sbin /sbin

set -x COPYFILE_DISABLE 1 # Turn off special handling of ._* files in tar, etc.
set -x EDITOR 'nvim'
set -x GO111MODULE on
set -x GOPATH $HOME
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x PAGER "/usr/bin/less -SR" # Don't wrap when paging, in eg: psql. Also, show color codes
set -x PYTHONDONTWRITEBYTECODE 1
set -x XDG_CONFIG_HOME "$HOME/.config" # Override any defaults to "$HOME/Library/Application Support"
# Add go and brew bins to PATH
set PATH $GOPATH/bin $PATH
set PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
set PATH /usr/local/opt/curl/bin $PATH
set PATH /usr/local/opt/findutils/libexec/gnubin $PATH
set PATH /usr/local/opt/gnu-sed/libexec/gnubin $PATH
set PATH /usr/local/opt/gnu-tar/libexec/gnubin $PATH
set PATH /usr/local/opt/gnu-time/libexec/gnubin $PATH
set PATH /usr/local/opt/grep/libexec/gnubin $PATH
set PATH /usr/local/opt/make/libexec/gnubin $PATH
set PATH /usr/local/opt/sqlite/bin $PATH

set -g fish_greeting ""
set -g fish_key_bindings fish_vi_key_bindings

source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
if test -e ~/.config/fish/config.override.fish
    source ~/.config/fish/config.override.fish
end

if not type -q fisher
    curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
    echo "Run `fisher` to install packages!"
end

if test -e /usr/local/opt/fzf/shell/key-bindings.fish
    source /usr/local/opt/fzf/shell/key-bindings.fish
    fzf_key_bindings
end

eval (direnv hook fish)
