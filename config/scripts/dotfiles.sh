#!/bin/bash

# Tell build process to exit if there are any errors.
set -oue pipefail

# Define o URL do repositório
REPO_URL="https://github.com/prasanthrangan/hyprdots.git"

# Define the destination directories for icons, themes, and cursors
ICON_DIR="$HOME/.icons"
THEME_DIR="$HOME/.themes"
CURSOR_DIR="$HOME/.local/share/icons"
FONT_DIR="$HOME/.fonts"

# Create directories if they don't exist
mkdir -p $ICON_DIR
mkdir -p $THEME_DIR
mkdir -p $CURSOR_DIR
mkdir -p $FONT_DIR

# Clone the repository to a temporary directory
TEMP_DIR=$(mktemp -d)
git clone $REPO_URL $TEMP_DIR

# Extract and copy cursors to the appropriate directory
tar -xzvf $TEMP_DIR/Source/arcs/Cursor_BibataIce.tar.gz -C $CURSOR_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Cursor_Gruvbox.tar.gz -C $CURSOR_DIR/

# Extract and copy fonts to the appropriate directory
tar -xzvf $TEMP_DIR/Source/arcs/Font_CascadiaCove.tar.gz -C $FONT_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Font_JetBrainsMono.tar.gz -C $FONT_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Font_MapleNerd.tar.gz -C $FONT_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Font_MaterialDesign.tar.gz -C $FONT_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Font_MononokiNerd.tar.gz -C $FONT_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Font_NotoSansCJK.tar.gz -C $FONT_DIR/

# Extract and copy themes to the appropriate directory
tar -xzvf $TEMP_DIR/Source/arcs/Gtk_CatppuccinLatte.tar.gz -C $THEME_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Gtk_CatppuccinMocha.tar.gz -C $THEME_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Gtk_CyberpunkEdge.tar.gz -C $THEME_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Gtk_DecayGreen.tar.gz -C $THEME_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Gtk_FrostedGlass.tar.gz -C $THEME_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Gtk_GraphiteMono.tar.gz -C $THEME_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Gtk_GruvboxRetro.tar.gz -C $THEME_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Gtk_MaterialSakura.tar.gz -C $THEME_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Gtk_RosePine.tar.gz -C $THEME_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Gtk_TokyoNight.tar.gz -C $THEME_DIR/

# Extract and copy icons to the appropriate directory
tar -xzvf $TEMP_DIR/Source/arcs/Icon_Gruvbox.tar.gz -C $ICON_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Icon_TelaBlack.tar.gz -C $ICON_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Icon_TelaBlue.tar.gz -C $ICON_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Icon_TelaDracula.tar.gz -C $ICON_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Icon_TelaGreen.tar.gz -C $ICON_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Icon_TelaGrey.tar.gz -C $ICON_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Icon_TelaPink.tar.gz -C $ICON_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Icon_TelaPurple.tar.gz -C $ICON_DIR/
tar -xzvf $TEMP_DIR/Source/arcs/Icon_TelaYellow.tar.gz -C $ICON_DIR/

# Clean up the temporary directory
rm -rf $TEMP_DIR

echo "Icons, themes, cursors, and fonts installed successfully!"
