# ██▄ ▄▀▄ ▄▀▀ █▄█
# █▄█ █▀█ ▄██ █ █

# User specific environment and startup programs
## Vim as default text editor
export VISUAL=vim
export EDITOR="$VISUAL"

## History configutarion
export HISTCONTROL=ignoredups               # Ingore duplicates
export HISTSIZE=1000                        # Set history size to 1000 lines
unset HISTFILE                              # Don't save to .zsh_history

## Edit PATH
if [ -d ~/.scripts ]; then
	export PATH="$PATH:$HOME/.scripts"
fi

## No overwriting existing files with the > operator.
set -o noclobber.

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
eval "$(starship init bash)"

## Source goto
[[ -s "/usr/local/share/goto.sh" ]] && source /usr/local/share/goto.sh
