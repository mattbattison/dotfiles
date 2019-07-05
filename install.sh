#!/bin/sh
set -e

THIS_DIR="$(cd $(dirname $0); pwd)"
OUTPUT_DIR="$THIS_DIR/.out"

echo "============================================================"
echo " 1/3 - Clearing output directory                            "
echo "============================================================\n"
if [ -e "$OUTPUT_DIR" ]; then
    rm -rv "$OUTPUT_DIR"
else
    echo "Nothing to clear!"
fi
echo

echo "============================================================"
echo " 2/3 - Linking files and directories from 'home' into \$HOME"
echo "============================================================\n"

mkdir -p "$OUTPUT_DIR/home"
for dotfile in $THIS_DIR/home/* $THIS_DIR/home/.*; do
    DOTFILE_NAME="$(basename "$dotfile")"
    if [ "$DOTFILE_NAME" = "." ] || [ "$DOTFILE_NAME" = ".." ] || [ "$DOTFILE_NAME" = "*" ] || [ "DOTFILE_NAME" = ".*" ]; then
        continue
    fi
    echo "Linking $DOTFILE_NAME..."
    DOTFILE_OUT="$OUTPUT_DIR/home/$DOTFILE_NAME"
    cp -r "$dotfile" "$DOTFILE_OUT"
    echo "- Copied $dotfile to $DOTFILE_OUT"
    DOTFILE_DEST="$HOME/$DOTFILE_NAME"
    if [ -h "$DOTFILE_DEST" ]; then
        echo "! Warning: $DOTFILE_DEST is already a link; it will be overwritten"
        rm "$DOTFILE_DEST"
    elif [ -e "$DOTFILE_DEST" ]; then
        DOTFILE_BACKUP="$DOTFILE_DEST.$(date +%s).old"
        echo "! Warning: $DOTFILE_DEST already exists; creating backup at $DOTFILE_BACKUP"
        mv "$DOTFILE_DEST" "$DOTFILE_BACKUP"
    fi
    ln -s "$DOTFILE_OUT" "$DOTFILE_DEST"
    echo "- Linked $DOTFILE_DEST to $DOTFILE_OUT\n"
done

echo "========================================================================="
echo " 3/3 - Linking files and directories from 'config' into \$XDG_CONFIG_HOME"
echo "=========================================================================\n"

mkdir -p "$OUTPUT_DIR/config"
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
    echo "Linking $CONFIG_NAME..."
    CONFIG_OUT="$OUTPUT_DIR/config/$CONFIG_NAME"
    cp -r "$config" "$CONFIG_OUT"
    echo "- Copied $config to $CONFIG_OUT"
    CONFIG_DEST="$CONFIG_DIR/$CONFIG_NAME"
        if [ -h "$CONFIG_DEST" ]; then
            echo "! Warning: $CONFIG_DEST is already a link; it will be overwritten"
            rm "$CONFIG_DEST"
        elif [ -e "$CONFIG_DEST" ]; then
            CONFIG_BACKUP="$CONFIG_DEST.$(date +%s).old"
            echo "! Warning: $CONFIG_DEST already exists; creating backup at $CONFIG_BACKUP"
            mv "$CONFIG_DEST" "$CONFIG_BACKUP"
        fi
        ln -s "$CONFIG_OUT" "$CONFIG_DEST"
        echo "- Linked $CONFIG_DEST to $CONFIG_OUT\n"
done

echo "Done!"
