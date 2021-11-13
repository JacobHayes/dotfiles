function _set_vim
    for handle in (nvr --nostart --serverlist)
        NVIM_LISTEN_ADDRESS=$handle nvr -c 'call SetBackground()'
    end
end
