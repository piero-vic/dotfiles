# ▄▀▀ █   █
# ▀▄▄ █▄▄ █

#################### ALIASES ####################

# Changing "ls" to "exa"
if [[ $(command -v exa) ]]; then
  alias ls="exa -alGh --group-directories-first --git"
  alias lt="exa -alTL=2 --group-directories-first --git --ignore-glob='.git|node_modules'"
fi

# Text editors
alias v="nvim"
alias code="codium"

# Changing "sed" to "gsed"
[[ $(command -v gsed) ]] && alias sed='gsed'

# Easier navigation
alias ..="cd .."
alias ...="cd ../.."
alias gt="goto"

# Extend mkdir
alias mkdir="mkdir -pv"

# Reload shell
alias reload="source ~/.zshrc"

# Easy clear
alias c="clear"

# Easy exit
alias e="exit"

# Easy history
alias h="history"
alias hs="history | grep"
alias hsi="history | grep -i"

# Confirm before overwriting something
alias cp="cp -ri"
alias mv="mv -i"
alias rm="rm -i"

# Recursively delete `.DS_Store` files
[[ $(uname) == 'Darwin' ]] && alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# the terminal rickroll
alias rr="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"

#################### FUNCTIONS ####################

## Create directory and navigate to it
# usage: mkdc <directory>
mkcd() { 
  mkdir -p -- "$1" && cd -P -- "$1" || return 
}

# Opens the current directory, otherwise opens the given
# usage: o / o <directory>
case $(uname) in
  'Darwin') OPEN_CMD='open' ;;
  'Linux') OPEN_CMD='xdg-open' ;;
esac

o() {
  if [ $# -eq 0 ]; then
    $OPEN_CMD .
  else
    $OPEN_CMD "$@"
  fi;
}

## Archive Extraction
# usage: ex <file>
ex() {
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"   ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1"      ;;
      *.deb)       ar x "$1"      ;;
      *.tar.xz)    tar xf "$1"    ;;
      *.tar.zst)   unzstd "$1"    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
