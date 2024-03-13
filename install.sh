#!/bin/bash
shopt -s nocasematch

this_script_dir="$(dirname "$(realpath "$0")")"
vimrc_destination_dir="$HOME/.config/nvim"
vimrc_destination="$vimrc_destination_dir/init.lua"
vimrc_source="$this_script_dir/init.lua"

main() {
	if [ -f "$vimrc_destination" ]; then
		log_line_info "File '$vimrc_destination' already exists. It will be backed up."
		log_info "Do you want to proceed [Y/n]? "
		read proceed_reply
		if ! [[ "$proceed_reply" =~ ^(y|yes|)$ ]]; then
			log_line_info "Aborting..."
			exit 1
		fi
		backup_vimrc
		rm "$vimrc_destination"
	fi
	ensure_nvimrc_dir_exists
	ln -s "$vimrc_source" "$vimrc_destination" \
		&& log_line_info "Created symoblic link '$vimrc_destination' to '$vimrc_source'" \
		|| { log_error "Failed to creating symoblic link '$vimrc_destination' to '$vimrc_source'" ; return 1 ; }
}

log_line_info() {
	echo "[install.sh] $*"
}

log_info() {
	echo -n "[install.sh] $*"
}

log_error() {
	echo "[install.sh] ERROR: $*"
}

backup_vimrc() {
	backups_count=1
	backup="$vimrc_source.bak$backups_count"
	while [[ -f "$backup" ]]; do
		let backups_count++
		backup="$vimrc_destination.bak$backups_count"
	done
	log_line_info "Backing up init.vim at '$backup'"
	cp "$vimrc_destination" "$backup"
}

ensure_nvimrc_dir_exists() {
	mkdir -p "$vimrc_destination_dir"
}

main && log_line_info "Success!" || log_line_info "Failed!"
