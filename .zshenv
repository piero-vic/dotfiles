# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ XDG Base Directory                                                         ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_PLUGINS="$ZDOTDIR/plugins"
export HISTCONTROL=ignoreboth
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export HISTSIZE=50000
export SAVEHIST=50000
export HISTCONTROL=ignoreboth
export HISTORY_IGNORE="(clear|ls|cd|pwd|exit|pass)*"

# NVM & Node
export NVM_DIR="$XDG_DATA_HOME"/nvm
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"

# GNU Wget
export WGETRC="$XDG_CONFIG_HOME/wgetrc"

# GKT
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ PATH                                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export PATH="$PATH:$HOME/.local/bin"

# Go
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Default programs                                                           ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export OS=$(uname)
type nvim >/dev/null && export EDITOR=nvim

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Program settings                                                           ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# Setup GTK Theme
export GTK_THEME=Arc-Dark

# QT
export QT_QPA_PLATFORMTHEME=qt6ct

# Firefox
export MOZ_ENABLE_WAYLAND=1

# bemenu
export BEMENU_OPTS="-n -c -s -i \
  -W 0.2 -H 26 -B 2 -l 15 \
  --single-instance \
  --fn 'JetBrainsMonoNerdFont 9' \
  --nb #0d0c0cff --nf #c5c9c5ff \
  --ab #0d0c0cff --af #c5c9c5ff \
  --hb #282727ff --hf #8ba4b0ff \
  --fb #0d0c0cff --ff #c5c9c5ff \
  --tb #0d0c0cff --tf #8ba4b0ff \
  --bdr #8ba4b0ff"

# dmenu-bluetooth
# https://github.com/Layerex/dmenu-bluetooth
export DMENU_BLUETOOTH_PROMPT="Bluetooth"
export DMENU_BLUETOOTH_LAUNCHER="bemenu"
