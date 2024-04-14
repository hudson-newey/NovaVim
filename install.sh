#!/bin/bash
set -eou pipefail

declare install_dir="$HOME/.local/bin/2nvim"

if [ -f $install_dir ]; then
    echo "Removing old 2nvim install"
    rm $install_dir
fi

cat << EOF > start.sh
#!/bin/bash
xrdb -query | grep -q 'XTerm\*vt100\.translationsa' |> /dev/null
if [ \$? != 0 ]; then xterm -e xrdb -merge ./xterm/.Xresources; fi
if [ \$# -eq 0 ]; then \$1 = "."; fi
xterm +sb -bg black -fg white -fa "M+1Code Nerd Font Mono" -fs 10 -title 2nvim -name $(pwd)/xterm/.Xresources -e nvim -u $(pwd)/init.lua -- \$@ &
EOF

cat << EOF > init.lua
package.path = '$(pwd)/?.lua;'..package.path
package.path = '$(pwd)/modules/?.lua;'..package.path
require("setup")
EOF

chmod +x start.sh

echo "Creating symlink in $install_dir"
ln -s $(pwd)/start.sh $install_dir
