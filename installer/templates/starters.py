def common_starter(runtime: str) -> str:
    return """#!/usr/bin/env bash
declare startPath="."
declare currentDir=$(pwd)

# if it is an absolute path, we do not want to use "realpath"
if [[ $1 = /* ]]; then
    startPath="$1"
else
    # if it is a relative path we can use realpath
    if [ $# -eq 0 ]; then
        startPath="$(realpath $currentDir)"
    else
        startPath="$(realpath $currentDir/$1)"
    fi
fi
"""


def wsl_starter(runtime: str) -> str:
    return f"""{common_starter(runtime)}
{runtime}/setup.sh {runtime}/init.lua $@ & > /dev/null
"""


# we have to override the $SHELL environment variable to support underline errors
def alacritty_starter(runtime: str) -> str:
    return f"""{common_starter(runtime)}
alacritty -T "$startPath - NovaVim" --class nvim --config-file {runtime}/configs/alacritty.toml -e {runtime}/setup.sh {runtime}/init.lua $@ & > /dev/null
"""


def xterm_starter(runtime: str) -> str:
    return f"""{common_starter(runtime)}
xterm +sb -bg black -fg white -fa "M+1Code Nerd Font Mono" -fs 10 -title "$startPath - NovaVim" -name {runtime}/configs/.Xresources -e {runtime}/setup.sh {runtime}/init.lua $@ & > /dev/null
xrdb -query | grep -q 'XTerm/*vt100/.translationsa' |> /dev/null
if [ $? != 0 ]; then xterm -e xrdb -merge ./configs/.Xresources; fi
"""
