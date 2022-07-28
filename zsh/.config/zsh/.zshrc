# ╔════════════════════════════════════════════════════════════════════════════╗
# ║                                                                            ║
# ║  ▀█▀ ▄▀▀ █▄█                                                               ║
# ║  █▄▄ ▄██ █ █                                                               ║
# ║                                                                            ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# Start tmux on every shell login
# type tmux > /dev/null \
# && [ -z "${TMUX}" ] \
# && { tmux attach || tmux; } >/dev/null 2>&1


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Configuration                                                              ║
# ╚════════════════════════════════════════════════════════════════════════════╝

autoload -U compinit
compinit -d ~/.cache/zsh/zcompdump-"$ZSH_VERSION"
zstyle ':completion:*' menu select

setopt autocd
setopt chaselinks
setopt noclobber
setopt emacs


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Aliases and Functions                                                      ║
# ╚════════════════════════════════════════════════════════════════════════════╝

alias c="clear"
alias e="exit"

alias cp="cp -ri"
alias mv="mv -i"
alias rm="rm -i"

alias mkdir="mkdir -p"

alias reload="source ~/.config/zsh/.zshrc"

type xdg-open >/dev/null && alias open='xdg-open'
type doas >/dev/null && alias sudo="doas"
type gsed >/dev/null && alias sed='gsed'

if type nvim >/dev/null; then
  alias vi="nvim"
  alias vim="nvim"
  alias v="nvim"
fi

if type exa >/dev/null; then
  alias ls='exa -a1 --icons --group-directories-first'
  alias la='exa -al --git --icons --group-directories-first'
  alias lt='exa -aTI ".git|node_modules" --icons --group-directories-first'
fi

mkcd() { mkdir -p "$1" && cd "$1" || exit; }
o() {
  if [ $# -eq 0 ]; then
    open .
  else
    open "$@"
  fi
}


## git

alias gs='git status'
alias ga='git add'
alias grs='git restore --staged'
alias gr='git rm'
alias gmv='git mv'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gl='git log'
alias glo='git log --oneline'
alias gd='git diff'
alias gds='git diff --staged'
alias pull='git pull'
alias push='git push'
alias gpuo='git push -u origin'
alias gst='git stash'
alias gstp='git stash pop'


## tmux

alias t='tmux'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

ta() {
  if [ $# -eq 0 ]; then
    tmux attach
  else
    tmux attach -t "$1"
  fi
}
tn() {
  tmux new -s "$1" -d
  tmux switch -t "$1"
}
ide() {
  tmux split-window -h -p 35
  tmux split-window -v -p 40
  nvim
}


## jrnl

alias j='jrnl'
alias je='j --edit'
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

# Display jrnl entries with glow | Usage: jg <date>
jg() {
  [ $# -eq 0 ] && date=$(date +"%Y-%m-01") || date=$1
  jrnl -from "$date" --format md | glow --pager -
}

# Display jrnl entries with slides | usage: js <date>
# This functions assumes the entris are separated by "---"
js() {
  [ $# -eq 0 ] && date=$(date +"%Y-%m-01") || date=$1
  jrnl -from "$date" --format md | slides
}


## MacOS => Cleanup & Homebrew
if [[ "$OS" = "Darwin" ]]; then
  alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
  alias bi='brew install'
  alias bic='brew install --cask'
  alias bui='brew uninstall'
  alias bl='brew list'
  alias bt="brew deps --tree --installed"
  alias bup='brew update && brew outdated && brew upgrade && brew cleanup'
fi


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Plugins and other applications                                             ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# Ruby
type rbenv >/dev/null && eval "$(rbenv init -)"

# NVM
[[ -f /usr/share/nvm/init-nvm.sh ]] && source /usr/share/nvm/init-nvm.sh

# Starship
type starship >/dev/null && eval "$(starship init zsh)"

# Plugins
ZSH_PLUGINS="/usr/share/zsh/plugins"

# Syntax Highlighting
[[ -d "$ZSH_PLUGINS/zsh-syntax-highlighting" ]] &&
  source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
