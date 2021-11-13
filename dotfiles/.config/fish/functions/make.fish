function make --wraps make
  # `fish -c` would reload my config file, which can override the existing shell's ones (ex: PATH updates from direnv).
  # Unfortunately fish doesn't provide a --noprofile flag, so fall back to using bash.
  bash --noprofile -c "
    while [ \$PWD != '/' ] && [ ! -e 'Makefile' ]; do
      cd ..
    done
    command make $argv # Run make even without a Makefile to allow `make --help`, etc
  "
end
