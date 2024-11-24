#!/usr/bin/env python3
import os
import sys
import stat
import shutil


def is_wsl() -> bool:
    try:
        with open("/proc/version", "r") as f:
            return "microsoft" in f.read().lower()
    except Exception:
        return False


def is_windows() -> bool:
    return sys.platform == "win32"


def has_alacritty() -> bool:
    return shutil.which("alacritty") is not None


def has_xterm() -> bool:
    return shutil.which("xterm") is not None


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
{runtime}/setup.sh {runtime}/init.lua $@
"""


# we have to override the $SHELL environment variable to support underline errors
def alacritty_starter(runtime: str) -> str:
    return f"""{common_starter(runtime)}
alacritty -T "$startPath - NovaVim" --class nvim --config-file {runtime}/configs/alacritty.toml -e {runtime}/setup.sh {runtime}/init.lua $@
"""


def xterm_starter(runtime: str) -> str:
    return f"""{common_starter(runtime)}
xterm +sb -bg black -fg white -fa "M+1Code Nerd Font Mono" -fs 10 -title "$startPath - NovaVim" -name {runtime}/configs/.Xresources -e {runtime}/setup.sh {runtime}/init.lua $@
xrdb -query | grep -q 'XTerm/*vt100/.translationsa' |> /dev/null
if [ $? != 0 ]; then xterm -e xrdb -merge ./configs/.Xresources; fi
"""


def init_module(runtime: str) -> str:
    return f"""
package.path = '{runtime}/?.lua;'..package.path
package.path = '{runtime}/modules/?.lua;'..package.path
require('setup')
"""


def main() -> None:
    home = os.getenv("HOME")
    bin_target = home + "/.local/bin/2nvim"
    runtime = os.path.dirname(os.path.realpath(__file__))
    starter_path = runtime + "/start.sh"
    init_module_path = runtime + "/init.lua"

    if os.path.exists(bin_target):
        print("Removing old 2nvim install")
        os.remove(bin_target)

    starter_template = ""
    if is_wsl():
        starter_template = wsl_starter(runtime)
    elif has_alacritty():
        starter_template = alacritty_starter(runtime)
    elif has_xterm():
        starter_template = xterm_starter(runtime)
    else:
        print("You do not have a supported terminal emulator installed")
        print("Supported terminals: Alacritty, XTerm, WSL")
        os.exit(1)

    with open(starter_path, "w") as file:
        file.write(starter_template)

    init_module_template = init_module(runtime)
    with open(init_module_path, "w") as file:
        file.write(init_module_template)

    current_permissions = os.stat(starter_path).st_mode
    new_permissions = current_permissions | stat.S_IXUSR

    print(f"Creating symlink in {starter_path}")
    os.chmod(starter_path, new_permissions)
    os.symlink(starter_path, bin_target)


if __name__ == "__main__":
    main()

