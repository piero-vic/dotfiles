#!/usr/bin/env bash

shopt -s nullglob globstar

password_dir=${PASSWORD_STORE_DIR-~/.password-store}
password_files=("$password_dir"/**/*.gpg)
password_files=("${password_files[@]#"$password_dir"/}")
password_files=("${password_files[@]%.gpg}")

password=$(printf '%s\n' "${password_files[@]}" | bemenu --no-exec --prompt="pass")

[[ -n $password ]] || exit

pass show -c "$password" && notify-send " $password" "Copied to clipboard"
