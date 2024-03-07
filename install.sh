#!/bin/bash

echo "Installing 2nvim"

if [ -f ~/.config/nvim/init.lua ]; then
    echo "Removing old start script"
    echo "nvim -u $(pwd)/init.lua -- \$@" > start.sh
    chmod +x start.sh
fi

if [ -f ~/.local/bin/2nvim ]; then
    echo "Removing old 2nvim"
    rm ~/.local/bin/2nvim
fi

ln -s $(pwd)/start.sh ~/.local/bin/2nvim
