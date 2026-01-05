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
# ║ History                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export HISTFILE="$XDG_STATE_HOME/zsh/history"
export SAVEHIST=9000
export HISTSIZE=9999

# https://zsh.sourceforge.io/Doc/Release/Options.html#History
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS

# Curate your shell history
# https://esham.io/2025/05/shell-history
function smite() {
	setopt LOCAL_OPTIONS ERR_RETURN PIPE_FAIL

	local opts=(-I)
	if [[ $1 == '-a' ]]; then
		opts=()
	elif [[ -n $1 ]]; then
		print >&2 'usage: smite [-a]'
		return 1
	fi

	fc -l -n $opts 1 |
		fzf --no-sort --multi |
		while IFS='' read -r command_to_delete; do
			printf 'Removing history entry "%s"\n' $command_to_delete
			local HISTORY_IGNORE="${(b)command_to_delete}"
			fc -W
			fc -p $HISTFILE $HISTSIZE $SAVEHIST
		done
}

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

# https://github.com/Schniz/fnm
type fnm >/dev/null && eval "$(fnm env --use-on-cd --shell zsh)"

# https://sdkman.io/
export SDKMAN_DIR="$XDG_DATA_HOME/sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# https://github.com/starship/starship
type starship >/dev/null && eval "$(starship init zsh)"

# https://github.com/ajeetdsouza/zoxide
type zoxide >/dev/null && eval "$(zoxide init --cmd cd zsh)"

# https://github.com/junegunn/fzf
if type fzf >/dev/null; then
  eval "$(fzf --zsh)"
  export FZF_DEFAULT_OPTS='--color=bw'
fi

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Extras                                                                     ║
# ╚════════════════════════════════════════════════════════════════════════════╝

[[ -s "$ZDOTDIR/extra.zsh" ]] && source "$ZDOTDIR/extra.zsh"
