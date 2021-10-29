# ▀█▀ ▄▀▀ █▄█
# █▄▄ ▄██ █ █

############ Environment and startup programs ############
export VISUAL=micro
export EDITOR="$VISUAL"

export HISTCONTROL=ignoreboth               # Ingore duplicates and command that start with spaces
export HISTSIZE=1000                        # Set history size to 1000 lines
unset HISTFILE                              # Don't save to .zsh_history

if [ -d ~/.scripts ]; then
	export PATH="$PATH:$HOME/.scripts"
fi

export PATH="$PATH:$HOME/Library/Python/3.9/bin"
export PATH="$HOME/.poetry/bin:$PATH"
export COINTOP_CONFIG="$HOME/.cointop/config.toml"

set -o noclobber                            # No overwriting existing files with the > operator.

########### User specific aliases and functions ###########
if [ -d ~/.zshrc.d ]; then
	for rc in ~/.zshrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi
unset rc

################# Plugins and other stuff #################
# Starship Prompt
eval "$(starship init zsh)"
# Completion
autoload -Uz compinit
compinit
# Source goto
[[ -s "/usr/local/share/goto.sh" ]] && source /usr/local/share/goto.sh
# Cargo
. "$HOME/.cargo/env"
