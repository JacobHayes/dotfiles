function notify
    if eval $argv
        osascript -e "display notification \"Complete!\" with title \"$argv\""
    else
        osascript -e "display notification \"Failed! 😞\" with title \"$argv\""
    end
end
