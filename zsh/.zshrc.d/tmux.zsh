# ▀█▀ █▄ ▄█ █ █ ▀▄▀
#  █  █ ▀ █ ▀▄█ █ █

alias t='tmux'

ta() {
	if [ $# -eq 0 ]; then
		tmux attach;
	else
		tmux attach -t "$@";
	fi;
}

alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'
