# ▀█▀ ▄▀▀ █▄█
# █▄▄ ▄██ █ █

# Start tmux on every shell login
[ -x "$(command -v tmux)" ] && [ -z "${TMUX}" ] && { tmux attach || tmux; } >/dev/null 2>&1

######## ENVIRONMENT VARIABLES #########
# Editor
export VISUAL="nvim"
export EDITOR="nvim"

# History
export HISTCONTROL=ignoreboth               # Ingore duplicates and command that start with spaces
export HISTSIZE=1000                        # Set history size to 1000 lines
unset HISTFILE                              # Don't save to .zsh_history

# PATH
[[ -d ~/Library/Python/3.9/bin ]] && export PATH="$PATH:$HOME/Library/Python/3.9/bin"
[[ -d ~/.poetry/bin ]] && export PATH="$PATH:$HOME/.poetry/bin"
[[ -d ~/.scripts ]] && export PATH="$PATH:$HOME/.scripts"

# Custom Programs
export MANPAGER="sh -c 'col -bx | bat -l man -p'"         # Use bat to color man pages
export EXA_GRID_ROWS=10                                   # Exa grid
export COINTOP_CONFIG="$HOME/.cointop/config.toml"        # Cointop

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
