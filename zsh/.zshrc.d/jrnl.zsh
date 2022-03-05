#   █ █▀▄ █▄ █ █
# ▀▄█ █▀▄ █ ▀█ █▄▄

# Composing
alias j='jrnl'
alias je='j --edit'

# Viewing
alias jl='j --list'

alias jt='j -on today'
alias jw='j -from "last week"'
alias jm='j -from $(date +"%Y-%m-01")'

alias jts='jt --short'
alias jtm='jt --format md'

alias jws='jw --short'
alias jwm='jw --format md'

alias jms='jm --short'
alias jmm='jm --format md'

## Display jrnl entries with glow
# usage: jg <date>
jg() {
  [ $# -eq 0 ] && date=$(date +"%Y-%m-01") || date=$@
  jrnl -from "$date" --format md | glow --pager -
}


## Display jrnl entries with slides
# usage: js <date>
js() {
  [ $# -eq 0 ] && date=$(date +"%Y-%m-01") || date=$@

  jrnl=$header$(jrnl -from "$date" --format md)

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
