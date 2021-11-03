#   █ █▀▄ █▄ █ █
# ▀▄█ █▀▄ █ ▀█ █▄▄

alias j='jrnl'
alias je='j --edit'
alias js='j --short'

## Display jrnl entries on glow
# usage: jglow <journal>
jg() {
  if [ $# -eq 0 ]; then
		jrnl -from "last week" --format md | glow - --pager
  else
    jrnl "$@" -from "last week" --format md | glow - --pager
  fi
}
