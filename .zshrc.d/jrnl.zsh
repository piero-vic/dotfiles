#   █ █▀▄ █▄ █ █
# ▀▄█ █▀▄ █ ▀█ █▄▄

# Composing
alias j='jrnl'
alias je='j --edit'

# Viewing
alias jl='j --list'
alias jt='j -on today'
alias jw='j -from "last week" -to today'
alias jm='j -from $(date +"%Y-%m-01")'

alias jts='jt --short'
alias jtp='jt --format pretty'
alias jtm='jt --format md'

alias jws='jw --short'
alias jwp='jw --format pretty'
alias jwm='jw --format md'

alias jms='jm --short'
alias jmp='jm --format pretty'
alias jmm='jm --format md'

## Display jrnl entries on glow
# usage: jg <journal>
jg() {
  if [ $# -eq 0 ]; then
    jrnl -on today --format md | glow --pager -
  else
    jrnl "$@" -on today --format md | glow --pager -
  fi
}

## Display jrnl entries on slides
# usage: js <journal>
js() {
  header='---\ntheme: /Users/piero/.dotfiles/.config/glamour/dark.json\n---\n\n'
  date=$(date +"%Y-%m-01")

  if [ $# -eq 0 ]; then
    jrnl=$header$(jrnl -from "$date" --format md)
  else
    jrnl=$header$(jrnl "$@" -from "$date" --format md)
  fi

  echo "$jrnl" | while IFS= read -r line; do
    if [[ "$line" =~ ^###.* ]]; then
      if [[ "$line" != *$date* ]]; then
        printf "---\n\n%s\n" "$line"
        date="${line:4:10}"
      else
        printf "%s\n" "$line"
      fi
    else
      printf "%s\n" "$line"
    fi
  done | slides
}
