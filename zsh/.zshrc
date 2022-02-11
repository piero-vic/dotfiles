# ▀█▀ ▄▀▀ █▄█
# █▄▄ ▄██ █ █

# Start tmux on every shell login
[ -x "$(command -v tmux)" ] && [ -z "${TMUX}" ] && { tmux attach || tmux; } >/dev/null 2>&1

#------------------------------
# Variables
#------------------------------
export VISUAL="nvim"
export EDITOR="nvim"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export EXA_GRID_ROWS=10
export COINTOP_CONFIG="$HOME/.cointop/config.toml"

#------------------------------
# History stuff
#------------------------------
export HISTCONTROL=ignoreboth
export HISTSIZE=1000
unset HISTFILE

#------------------------------
# Configuration
#------------------------------
autoload -Uz compinit && compinit
set -o noclobber
[[ -d ~/.scripts ]] && export PATH="$PATH:$HOME/.scripts"

#------------------------------
# Aliases and Functions
#------------------------------
if [ -d ~/.zshrc.d ]; then
  for rc in ~/.zshrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc

#------------------------------
# Plugins and other stuff
#------------------------------
# Poetry
[[ -d ~/Library/Python/3.9/bin ]] && export PATH="$PATH:$HOME/Library/Python/3.9/bin"
[[ -d ~/.poetry/bin ]] && export PATH="$PATH:$HOME/.poetry/bin"
# Ruby
export PATH="$PATH:/usr/local/opt/ruby/bin"
eval "$(rbenv init -)"
# Goto
[[ -s "/usr/local/share/goto.sh" ]] && source /usr/local/share/goto.sh
# Starship
eval "$(starship init zsh)"
