function agvim --wraps ag
    ag $argv -l | xargs -I{} nvim {}
end
