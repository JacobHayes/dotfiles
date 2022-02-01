# This is probably the hackiest thing I've ever written :)
function c
  set dir (python3 -c '
shortcuts = {
    "arti": "~/src/github.com/artigraph/artigraph",
    "dot": "~/src/github.com/JacobHayes/dotfiles",
    "gh": "~/src/github.com",
}

if __name__ == "__main__":
    from argparse import ArgumentParser
    from os.path import expanduser
    import sys

    parser = ArgumentParser()
    parser.add_argument("key")
    args = parser.parse_args()
    if args.key in shortcuts:
        print(expanduser(shortcuts[args.key]))
    else:
        sys.exit(f"Unknown shortcut {args.key}")
' $argv)
  set ret $status
  if test -n "$dir";
    cd $dir
  end
  return $ret
end
