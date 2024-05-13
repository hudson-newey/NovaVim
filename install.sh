#!/usr/bin/env bash
set -eou pipefail

declare path_dir="$HOME/.local/bin/2nvim"
declare use_alacritty=true;
declare is_wsl=false;

if [ -f $path_dir ]; then
	echo "Removing old 2nvim install"
	rm $path_dir
fi

if uname -a | grep -q '^Linux.*Microsoft'; then
	is_wsl=true

	echo "Warning! Using NovaVim in WSL is not recommended as we cannot maintain a terminal emulator config"
	read -p "Press any key to continue..."
fi

which alacritty > /dev/null
if [ $? != 0 ] && [ $is_wsl == false ]; then
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

# even though it is a bit slower, I invoke PWD in a sub shell every time I reference
# a local file to keep consistant with the reset of the script
# this is because sometimes I refer to absolute paths
# to prevent the program from breaking due to the mixture of absolute and relative paths
# I have opted to just use relative paths (even if that means a perf hit during install)
echo "#!/usr/bin/env bash" > "$(pwd)/start.sh"

# If no arguments are provided to 2nvim, we want to make it so that it starts
# in the current directory
cat << EOF >> "$(pwd)/start.sh"
declare startPath=".";
if [ \$# -eq 0 ]; then
	startPath="\$(pwd)"
else
	startPath="\$(pwd)/\$1"
fi
EOF

if [ $use_alacritty == true ] && [ $is_wsl == false ]; then
	# alacritty startup command
	cat << EOF >> "$(pwd)/start.sh"
	alacritty -T "\$startPath - NovaVim" --config-file $(pwd)/alacritty/alacritty.toml -e nvim -u $(pwd)/init.lua -- \$@ & > /dev/null
EOF
else
	# xterm startup command
	# this is so complicated because we have to load in the fonts, overwrite ctrl + V etc...
	cat << EOF >> "./start.sh"
	xterm +sb -bg black -fg white -fa "M+1Code Nerd Font Mono" -fs 10 -title "\$startPath - NovaVim" -name $(pwd)/xterm/.Xresources -e nvim -u $(pwd)/init.lua -- \$@ & > /dev/null
xrdb -query | grep -q 'XTerm\*vt100\.translationsa' |> /dev/null
if [ \$? != 0 ]; then xterm -e xrdb -merge ./xterm/.Xresources; fi
EOF
fi

# TODO: Handle differnt installation targets better
if [ $is_wsl == true ]; then
	cat << EOF >> "$(pwd)/start.sh"
	nvim -u $(pwd)/init.lua -- \$@
EOF
fi

cat << EOF > "$(pwd)/init.lua"
package.path = '$(pwd)/?.lua;'..package.path
package.path = '$(pwd)/modules/?.lua;'..package.path
require('setup')
EOF

chmod +x "$(pwd)/start.sh"

echo "Creating symlink in $path_dir"
ln -s "$(pwd)/start.sh" $path_dir
