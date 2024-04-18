#!/bin/bash
set -eou pipefail

declare install_dir="$HOME/.local/bin/2nvim"
declare use_alacritty=true;

if [ -f $install_dir ]; then
	echo "Removing old 2nvim install"
	rm $install_dir
fi

which alacritty > /dev/null
if [ $? != 1 ]; then
	echo "
Alacritty not found, we recommend using alacritty over xterm as the terminal emulator
To install alacritty, follow the instructions at
	https://alacritty.org/
"

	read -p "Do you want to use xterm instead of alacritty? [y/n]: " use_xterm

	if [ $use_xterm == "y" ]; then
		use_alacritty=false
	fi
fi

echo "#!/bin/bash" > start.sh

cat << EOF >> start.sh
if [ \$# -eq 0 ]; then \$1 = "."; fi
EOF

if [ $use_alacritty == true ]; then
	# alacritty startup command
	cat << EOF >> start.sh
alacritty -T NovaVim --config-file $(pwd)/alacritty/alacritty.toml -e nvim -u $(pwd)/init.lua -- \$@ & > /dev/null
EOF
else
	# xterm startup command
	# this is so complicated because we have to load in the fonts, overwrite ctrl + V etc...
	cat << EOF >> start.sh
xterm +sb -bg black -fg white -fa "M+1Code Nerd Font Mono" -fs 10 -title NovaVim -name $(pwd)/xterm/.Xresources -e nvim -u $(pwd)/init.lua -- \$@ & > /dev/null
xrdb -query | grep -q 'XTerm\*vt100\.translationsa' |> /dev/null
if [ \$? != 0 ]; then xterm -e xrdb -merge ./xterm/.Xresources; fi
EOF
fi

cat << EOF > init.lua
package.path = '$(pwd)/?.lua;'..package.path
package.path = '$(pwd)/modules/?.lua;'..package.path
require("setup")
EOF

chmod +x start.sh

echo "Creating symlink in $install_dir"
ln -s $(pwd)/start.sh $install_dir
