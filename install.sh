#!/bin/bash
shopt -s nocasematch

this_script_dir="$(dirname "$(realpath "$0")")"
vimrc_destination_dir="$HOME/.config/nvim"
vimrc_destination="$vimrc_destination_dir/init.vim"
vimrc_source="$this_script_dir/init.vim"

main() {
	if [ -f "$vimrc_destination" ]; then
		echo File "'$vimrc_destination'" already exists. It will be backed up.
		read -p "Do you want to proceed [Y/n]? "
		if ! [[ "$REPLY" =~ ^(y|yes|)$ ]]; then
			echo Aborting...
			exit 1
		fi
		backup_vimrc
		rm "$vimrc_destination"
	fi
	echo Creating symoblic link "'$vimrc_destination'" to "'$vimrc_source'"
	ln -s "$vimrc_source" "$vimrc_destination"
	echo Finished!
}

backup_vimrc() {
	backups_count=1
	backup="$vimrc_source.bak$backups_count"
	while [[ -f "$backup" ]]; do
		let backups_count++
		backup="$vimrc_destination.bak$backups_count"
	done
	echo Backing up init.vim at "'$backup'"
	cp "$vimrc_destination" "$backup"
}

main
