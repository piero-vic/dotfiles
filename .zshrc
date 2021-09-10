# ▀█▀ ▄▀▀ █▄█
# █▄▄ ▄██ █ █

# User specific environment and startup programs
## Vim as default text editor
export VISUAL=vim
export EDITOR="$VISUAL"

## History configutarion
export HISTCONTROL=ignoredups               # Ingore duplicates
export HISTSIZE=1000                        # Set history size to 1000 lines
unset HISTFILE                              # Don't save to .zsh_history

# User specific aliases and functions
if [ -d ~/.zshrc.d ]; then
	for rc in ~/.zshrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

# Plugins and other stuff
## Starship Prompt
eval "$(starship init zsh)"
