function _set_tmuxpwd --on-variable PWD --description "Set a pane specific tmux PWD var to use when creating new panes/windows."
    if status --is-command-substitution
        return
    end
    # tmux's pane_current_path doesn't work reliably with fish 3, so we'll set this var for each pane and reference that
    # in ~/.tmux.conf.
    tmux setenv TMUXPWD_(tmux display -p "#D" | tr -d %) "$PWD"
end

function _unset_tmuxpwd --on-event fish_exit --description "Clean up the pane specific tmux PWD var on shell exit."
    tmux setenv -u TMUXPWD_(tmux display -p "#D" | tr -d %)
end
