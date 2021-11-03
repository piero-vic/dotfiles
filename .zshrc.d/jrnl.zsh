#   █ █▀▄ █▄ █ █
# ▀▄█ █▀▄ █ ▀█ █▄▄

# Composing
alias j='jrnl'
alias je='j --edit'

# Viewing
alias jl='j --list'
alias jt='j -on today'
alias jw='j -from "last week" -to today'

alias jts='jt --short'
alias jtp='jt --format pretty'

alias jws='jw --short'
alias jwp='jw --format pretty'

## Display jrnl entries on glow
# usage: jglow <journal>
jg() {
  if [ $# -eq 0 ]; then
		jrnl -from "last week" --format md | glow - --pager
  else
    jrnl "$@" -from "last week" --format md | glow - --pager
  fi
}
