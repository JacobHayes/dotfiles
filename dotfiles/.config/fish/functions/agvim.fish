function agvim --wraps ag
    ag -l -- $argv | xargs -I{} nvim {} +"/\v$argv"
end
