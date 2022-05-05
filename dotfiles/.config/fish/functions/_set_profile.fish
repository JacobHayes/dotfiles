function _set_profile
  echo "Setting macos..."
  _set_macos $argv # Set first since nvim uses this setting

  echo "Setting iterm..."
  _set_iterm $argv
  echo "Setting tmux..."
  _set_tmux $argv
  echo "Setting vim..."
  _set_vim $argv
end
