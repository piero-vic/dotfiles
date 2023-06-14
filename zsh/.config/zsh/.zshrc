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

alias cp="cp -ri"
alias mv="mv -i"
alias rm="rm -i"

alias mkdir="mkdir -p"

alias reload="source ~/.config/zsh/.zshrc"

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

type zoxide >/dev/null && alias cd='z'


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
function t() {
  [ -z "${TMUX}" ] && tmux attach || tmux
}

function tn() {
  tmux new -s "$1" -d
  tmux switch -t "$1"
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Plugins and other applications                                             ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# Ruby
type rbenv >/dev/null && eval "$(rbenv init -)"

# NVM
[[ -f /usr/share/nvm/init-nvm.sh ]] && source /usr/share/nvm/init-nvm.sh

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Starship
type starship >/dev/null && eval "$(starship init zsh)"

# zoxide
type zoxide >/dev/null && eval "$(zoxide init zsh)"

# Syntax Highlighting
if [[ -d "$ZSH_PLUGINS/zsh-syntax-highlighting" ]]; then
  source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
