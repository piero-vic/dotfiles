# ██▄ ▄▀▄ ▄▀▀ █▄█
# █▄█ █▀█ ▄██ █ █

############ Environment and startup programs ############
export VISUAL=vim
export EDITOR="$VISUAL"

export HISTCONTROL=ignoreboth               # Ingore duplicates and command that start with spaces
export HISTSIZE=1000                        # Set history size to 1000 lines
unset HISTFILE                              # Don't save to .bash_history

if [ -d ~/.scripts ]; then
	export PATH="$PATH:$HOME/.scripts"
fi

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
eval "$(starship init bash)"
# Source goto
[[ -s "/usr/local/share/goto.sh" ]] && source /usr/local/share/goto.sh