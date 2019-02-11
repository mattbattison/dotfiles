#!/bin/sh

THIS_DIR="$(cd $(dirname $0); pwd)"

echo "============================================================"
echo " 1/2 - Linking files and directories from 'home' into \$HOME"
echo "============================================================\n"

for dotfile in $THIS_DIR/home/* $THIS_DIR/home/.*; do
	DOTFILE_NAME="$(basename "$dotfile")"
	if [ "$DOTFILE_NAME" = "." ] || [ "$DOTFILE_NAME" = ".." ] || [ "$DOTFILE_NAME" = "*" ] || [ "DOTFILE_NAME" = ".*" ]; then
		continue
	fi
	DOTFILE_DEST="$HOME/$DOTFILE_NAME"
	echo "Linking $DOTFILE_NAME..."
	if [ -h "$DOTFILE_DEST" ]; then
		echo "! Warning: $DOTFILE_DEST is already a link; it will be overwritten"
		rm "$DOTFILE_DEST"
	elif [ -e "$DOTFILE_DEST" ]; then
		DOTFILE_BACKUP="$DOTFILE_DEST.$(date +%s).old"
		echo "! Warning: $DOTFILE_DEST already exists; creating backup at $DOTFILE_BACKUP"
		mv "$DOTFILE_DEST" "$DOTFILE_BACKUP"
	fi
	ln -s "$dotfile" "$DOTFILE_DEST"
	echo "- Linked $DOTFILE_DEST to $dotfile\n"
done

echo "========================================================================="
echo " 2/2 - Linking files and directories from 'config' into \$XDG_CONFIG_HOME"
echo "=========================================================================\n"

echo "Locating config directory..."
if [ -z "$XDG_CONFIG_HOME" ]; then
	echo "- \$XDG_CONFIG_HOME is not set; using the default value: \$HOME/.config"
	CONFIG_DIR="$HOME/.config"
else
	echo "- \$XDG_CONFIG_HOME is set to $XDG_CONFIG_HOME"
	CONFIG_DIR="$XDG_CONFIG_HOME"
fi

if [ ! -d "$CONFIG_DIR" ]; then
	echo "- $CONFIG_DIR does not exist; creating it"
	mkdir -p "$CONFIG_DIR"
fi
echo

for config in $THIS_DIR/config/* $THIS_DIR/config/.*; do
	CONFIG_NAME="$(basename "$config")"
	if [ "$CONFIG_NAME" = "." ] || [ "$CONFIG_NAME" = ".." ] || [ "$CONFIG_NAME" = "*" ] || [ "$CONFIG_NAME" = ".*" ]; then
		continue
	fi
	CONFIG_DEST="$CONFIG_DIR/$CONFIG_NAME"
	echo "Linking $CONFIG_NAME..."
        if [ -h "$CONFIG_DEST" ]; then
                echo "! Warning: $CONFIG_DEST is already a link; it will be overwritten"
                rm "$CONFIG_DEST"
        elif [ -e "$CONFIG_DEST" ]; then
                CONFIG_BACKUP="$CONFIG_DEST.$(date +%s).old"
                echo "! Warning: $CONFIG_DEST already exists; creating backup at $CONFIG_BACKUP"
                mv "$CONFIG_DEST" "$CONFIG_BACKUP"
        fi
        ln -s "$config" "$CONFIG_DEST"
        echo "- Linked $CONFIG_DEST to $config\n"
done

echo "Done!"
