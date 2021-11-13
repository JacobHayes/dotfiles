function tmpvim
    set tmpfile (mktemp --suffix $argv)
    nvim $tmpfile
    rm $tmpfile
end
