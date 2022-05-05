c.TerminalInteractiveShell.editing_mode = "vi"

# Fix slow insert->command mode toggle: https://github.com/ipython/ipython/issues/13443
c.TerminalInteractiveShell.emacs_bindings_in_vi_insert_mode = False
# NOTE: Setting this shorter reduces the delay to enter command mode, but also seems to
# shorten the amount of time available to enter compound commands (eg: `dd`).
c.TerminalInteractiveShell.timeoutlen = 0.25
