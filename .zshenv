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
export PAGER=less

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Program settings                                                           ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# QT
export QT_QPA_PLATFORMTHEME=qt6ct

# Firefox
export MOZ_ENABLE_WAYLAND=1

# dmenu-bluetooth
# https://github.com/Layerex/dmenu-bluetooth
export DMENU_BLUETOOTH_PROMPT="Bluetooth"
export DMENU_BLUETOOTH_LAUNCHER="rofi -sync -dmenu -i"
