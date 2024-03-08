#!/bin/bash

echo "Installing 2nvim"

echo "Configuring xterm"

# if there is a previous install we don't want to reconfigure xterm
if [ -f ~/.local/bin/2nvim ]; then
	xterm -e xrdb -merge ~/.Xresources
fi

if [ -f ~/.config/nvim/init.lua ]; then
    echo "Removing old start script"
    echo "xterm +sb -bg black -fg white -fa \"M+1Code Nerd Font Mono\" -fs 10 -e nvim -u $(pwd)/init.lua -- \$@ &" > start.sh
    chmod +x start.sh
fi

if [ -f ~/.local/bin/2nvim ]; then
    echo "Removing old 2nvim"
    rm ~/.local/bin/2nvim
fi

ln -s $(pwd)/start.sh ~/.local/bin/2nvim
