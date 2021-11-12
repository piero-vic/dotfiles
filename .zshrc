# ▀█▀ ▄▀▀ █▄█
# █▄▄ ▄██ █ █

######## Environment and startup programs #########
export VISUAL="atom"
export EDITOR="micro"

export HISTCONTROL=ignoreboth               # Ingore duplicates and command that start with spaces
export HISTSIZE=1000                        # Set history size to 1000 lines
unset HISTFILE                              # Don't save to .zsh_history

export COINTOP_CONFIG="$HOME/.cointop/config.toml"

export PATH="$PATH:$HOME/Library/Python/3.9/bin"
export PATH="$HOME/.poetry/bin:$PATH"
if [ -d ~/.scripts ]; then
	export PATH="$PATH:$HOME/.scripts"
fi

########### User specific configuration ###########
autoload -Uz compinit && compinit           # Completion
set -o noclobber                            # No overwriting existing files with the > operator.

####### User specific aliases and functions #######
if [ -d ~/.zshrc.d ]; then
	for rc in ~/.zshrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi
unset rc

########### Plugins and other stuff ###############
eval "$(starship init zsh)"
[[ -s "/usr/local/share/goto.sh" ]] && source /usr/local/share/goto.sh
. "$HOME/.cargo/env"
