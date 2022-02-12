# Set a clean default PATH
set PATH /usr/bin /bin /usr/sbin /sbin
# Add the Homebrew paths - Add M1 paths later so they have priority.
eval (/usr/local/bin/brew shellenv)
eval (/opt/homebrew/bin/brew shellenv)
set PATH /opt/homebrew/opt/coreutils/libexec/gnubin $PATH
set PATH /opt/homebrew/opt/curl/bin $PATH
set PATH /opt/homebrew/opt/findutils/libexec/gnubin $PATH
set PATH /opt/homebrew/opt/gnu-sed/libexec/gnubin $PATH
set PATH /opt/homebrew/opt/gnu-tar/libexec/gnubin $PATH
set PATH /opt/homebrew/opt/gnu-time/libexec/gnubin $PATH
set PATH /opt/homebrew/opt/grep/libexec/gnubin $PATH
set PATH /opt/homebrew/opt/libpq/bin/ $PATH
set PATH /opt/homebrew/opt/make/libexec/gnubin $PATH
set PATH /opt/homebrew/opt/sqlite/bin $PATH
set PATH $HOME/.local/bin $PATH
set PATH $HOME/bin $PATH
# Remove brew's uname symlink, which on M1 will *always* report arm64, even with `arch -x86_64 ...` [1]
#
# 1: https://github.com/Homebrew/homebrew-core/issues/71782
rm -f /opt/homebrew/opt/coreutils/libexec/gnubin/uname

set -x COPYFILE_DISABLE 1 # Turn off special handling of ._* files in tar, etc.
set -x EDITOR 'nvim'
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x PAGER /opt/homebrew/bin/less -SR # Don't wrap when paging, in eg: psql. Also, show color codes
set -x PYTHONDONTWRITEBYTECODE 1
# Add more: https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html#variables
set -x XDG_CACHE_HOME "$HOME/.cache" # Override defaults to "$HOME/Library/Application Support"
set -x XDG_CONFIG_HOME "$HOME/.config" # Override defaults to "$HOME/Library/Caches"

alias g="git"
alias ll="ls -AHohp"
alias vim="nvim"
alias x86="arch -x86_64"
alias x86bash="arch -x86_64 /bin/bash" # ignore M1 brew's bash
alias x86brew="arch -x86_64 /usr/local/bin/brew"

set -g fish_greeting ""
set -g fish_key_bindings fish_vi_key_bindings

source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
if test -e ~/.config/fish/config.override.fish
    source ~/.config/fish/config.override.fish
end

if not type -q fisher
    curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
    echo "Run `fisher` to install packages!"
end

if test -e /opt/homebrew/opt/fzf/shell/key-bindings.fish
    source /opt/homebrew/opt/fzf/shell/key-bindings.fish
    fzf_key_bindings
end

# Support things like "direnv exec {path} fish" for long lived env mocking outside the path. We don't want to source the
# direnv hooks because they'd _disable_ itself as we're outside the core path.
if set -q DIRENV_IN_ENVRC
    # The DIRENV_DIR includes a leading hyphen for some reason
    set direnv_dir (echo $DIRENV_DIR | cut -c 2-)

    functions --copy fish_prompt _fish_prompt
    function fish_prompt
      echo -n "["(basename $direnv_dir | tr -d '\n')"] "
      _fish_prompt
    end
else
    direnv hook fish | source
    direnv export fish | source
end

# echo "Adding shadowsocks proxy lines"
# set -x http_proxy "http://127.0.0.1:1087"
# set -x https_proxy "http://127.0.0.1:1087"
