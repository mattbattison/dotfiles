#!/bin/sh

THIS_DIR="$(cd $(dirname $0); pwd)"

for dotfile in $THIS_DIR/files/*; do
	DOTFILE_NAME="$(basename "$dotfile")"
	DOTFILE_DEST="$HOME/.$DOTFILE_NAME"
	echo "Linking $DOTFILE_NAME..."
	if [ -h "$DOTFILE_DEST" ]; then
		echo "! Warning: $DOTFILE_DEST is already a link - it will be overwritten"
		rm "$DOTFILE_DEST"
	elif [ -e "$DOTFILE_DEST" ]; then
		DOTFILE_BACKUP="$DOTFILE_DEST.$(date +%s).old"
		echo "! Warning: $DOTFILE_DEST already exists - creating backup at $DOTFILE_BACKUP"
		mv "$DOTFILE_DEST" "$DOTFILE_BACKUP"
	fi
	ln -s "$dotfile" "$DOTFILE_DEST"
	echo "- Linked $DOTFILE_DEST to $dotfile\n"
done

echo "Done!"
