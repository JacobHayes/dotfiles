# Using `--wraps hub` gives better GH completion, but it not as good for stock commands.
#
# TODO: Can I use /usr/local/share/fish/vendor_completions.d/hub.fish at all?
function g --wraps git
    hub $argv
end
