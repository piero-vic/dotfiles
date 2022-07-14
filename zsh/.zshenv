# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ XDG Base Directory                                                         ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTCONTROL=ignoreboth
export HISTFILE="$XDG_STATE_HOME/zsh/history"

# Ruby
export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle"
export SOLARGRAPH_CACHE="$XDG_CACHE_HOME/solargraph"

# NVM & Node
export NVM_DIR="$XDG_DATA_HOME"/nvm
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# Cointop
export COINTOP_CONFIG="$XDG_CONFIG_HOME/cointop/config.toml"

# GNU Wget
export WGETRC="$XDG_CONFIG_HOME/wgetrc"


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ PATH                                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/share/npm/bin"
export PATH="$PATH:$HOME/.local/bin"


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Default programs                                                           ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export OS=$(uname)
type nvim >/dev/null && export EDITOR=nvim
type bat >/dev/null && export MANPAGER="sh -c 'col -bx | bat -l man -p'"
