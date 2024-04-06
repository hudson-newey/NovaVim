#!/bin/bash
set -eou pipefail

declare install_dir="$HOME/.local/bin/2nvim"

if [ -f $install_dir ]; then
    echo "Removing old 2nvim install"
    rm $install_dir
fi

echo "xterm +sb -bg black -fg white -fa \"M+1Code Nerd Font Mono\" -fs 10 -name $(pwd)/xterm/.Xresources -e nvim -u $(pwd)/init.lua -- \$@ &" > start.sh
chmod +x start.sh

echo "Creating symlink in $install_dir"
ln -s $(pwd)/start.sh $install_dir
