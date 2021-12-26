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
alias jtm='jt --format md'
alias jtg='jtm | glow --pager -'

alias jws='jw --short'
alias jwm='jw --format md'
alias jwg='jwm | glow --pager -'

alias jms='jm --short'
alias jmm='jm --format md'
alias jmg='jmm | glow --pager -'

## Display jrnl entries on slides
# usage: js <journal>
js() {
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
