function _set_profile
  _set_macos $argv # Set first since nvim uses this setting

  _set_iterm $argv
  _set_tmux $argv
  _set_vim $argv
end
