#!/bin/bash

set -e

main() {
	backup
	echo Installing...
	[[ -f ~/.config/nvim/ ]] || mkdir ~/.config/nvim/
	cp init.lua ~/.config/nvim/
	echo Success.
}

dir_is_not_empty() {
	find "$1" -mindepth 1 -maxdepth 1 | read
	return
}

backup() {
	if [[ -e ~/.config/nvim/ ]] && dir_is_not_empty ~/.config/nvim ; then
		echo "Directory '$HOME/.config/nvim' already exists."
		while :; do
			read -p  "Do you want to make backup and continue? [y/N] "
			if [[ "$REPLY" =~ [yY] ]]; then
				tempdir="$(mktemp -d ~/.config/nvim.bak.XXX)"
				rmdir "$tempdir"
				mv ~/.config/nvim/ "$tempdir"
				echo "Backed up '$HOME/.config/nvim/' to '$tempdir/'."
				break
			elif [[ "$REPLY" =~ [nN] || -z "$REPLY" ]]; then
				echo Aborting.
				exit 1
			fi
		done
	fi
}

main
