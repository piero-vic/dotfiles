# ╔════════════════════════════════════════════════════════════════════════════╗
# ║                                                                            ║
# ║  ▀█▀ ▄▀▀ █▄█                                                               ║
# ║  █▄▄ ▄██ █ █                                                               ║
# ║                                                                            ║
# ╚════════════════════════════════════════════════════════════════════════════╝

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

type bat >/dev/null &&
	alias cat="bat"

if type nvim >/dev/null; then
	alias vi="nvim"
	alias vim="nvim"
	alias v="nvim"
fi

if type eza >/dev/null; then
	alias ls='eza -a1 --icons --group-directories-first'
	alias la='eza -al --git --icons --group-directories-first'
	alias lt='eza -aTI ".git|node_modules" --icons --group-directories-first'
fi

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

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Plugins and other applications                                             ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# SSH
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

# fnm
type fnm >/dev/null && eval "$(fnm env --use-on-cd --shell zsh)"

# SDKMAN
export SDKMAN_DIR="$XDG_DATA_HOME/sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# Starship
type starship >/dev/null && eval "$(starship init zsh)"

# zoxide
type zoxide >/dev/null && eval "$(zoxide init --cmd cd zsh)"

# fzf
type fzf >/dev/null && eval "$(fzf --zsh)"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Extras                                                                     ║
# ╚════════════════════════════════════════════════════════════════════════════╝

[[ -s "$ZDOTDIR/extra.zsh" ]] && source "$ZDOTDIR/extra.zsh"
