#!/bin/bash

echo "Installing 2nvim"

if [ -f ~/.config/nvim/init.lua ]; then
    echo "Removing old start script"
    echo "xterm +sb -bg black -fg white -fa \"M+1Code Nerd Font Mono\" -fs 10 -name $(pwd)/.Xresources -e nvim -u $(pwd)/init.lua -- \$@ &" > start.sh
    chmod +x start.sh
fi

if [ -f ~/.local/bin/2nvim ]; then
    echo "Removing old 2nvim"
    rm ~/.local/bin/2nvim
fi

ln -s $(pwd)/start.sh ~/.local/bin/2nvim
