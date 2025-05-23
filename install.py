#!/usr/bin/env python3
import os
import sys
import stat
import shutil
import subprocess


UNSATISFIED_DEPENDENCY_ERROR = 1


def is_wsl() -> bool:
    try:
        with open("/proc/version", "r") as f:
            return "microsoft" in f.read().lower()
    except Exception:
        return False


def is_windows() -> bool:
    return sys.platform == "win32"


# neovide doesn't have the level of configuration that I require for 2nvim
# most importantly, you can't get ctrl + V working, can't re-bind keys and
# neovide comes inbuilt with a bunch of hidden shortcuts e.g. ctrl + shift + \
# that you cannot override
def has_neovide() -> bool:
    return False
    # return shutil.which("neovide") is not None


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
{runtime}/setup.sh {runtime}/init.lua $@ & > /dev/null
"""


# we have to override the $SHELL environment variable to support underline errors
def alacritty_starter(runtime: str) -> str:
    return f"""{common_starter(runtime)}
alacritty -T "$startPath - NovaVim" --class nvim --config-file {runtime}/configs/alacritty.toml -e {runtime}/setup.sh {runtime}/init.lua $@ & > /dev/null
"""


# this alacritty starter uses a yaml config so that older alacritty versions
# present on Debian stable and OpenSUSE leap can use an alacritty config
# instead of falling back to xterm
def yaml_alacritty_starter(runtime: str) -> str:
    return f"""{common_starter(runtime)}
alacritty -T "$startPath - NovaVim" --class nvim --config-file {runtime}/configs/alacritty.yaml -e {runtime}/setup.sh {runtime}/init.lua $@ & > /dev/null
"""

# we have to override the $SHELL environment variable to support underline errors
def neovide_starter(runtime: str) -> str:
    home_dir = os.environ["HOME"]
    os.makedirs(f"{home_dir}/.config/neovide/", exist_ok=True)
    shutil.copy(f"{runtime}/configs/neovide.toml", f"{home_dir}/.config/neovide/config.toml")
    return f"""{common_starter(runtime)}
neovide --maximized $@ -- -u {runtime}/init.lua & > /dev/null
"""


def xterm_starter(runtime: str) -> str:
    return f"""{common_starter(runtime)}
xterm +sb -bg black -fg white -fa "M+1Code Nerd Font Mono" -fs 10 -title "$startPath - NovaVim" -name {runtime}/configs/.Xresources -e {runtime}/setup.sh {runtime}/init.lua $@ & > /dev/null
xrdb -query | grep -q 'XTerm/*vt100/.translationsa' |> /dev/null
if [ $? != 0 ]; then xterm -e xrdb -merge ./configs/.Xresources; fi
"""


def has_font(font: str) -> bool:
    try:
        output = subprocess.check_output(["fc-list", font])
        if output == b"":
            return False
    except Exception:
        return False

    return True


def check_required_fonts() -> None:
    required_fonts = [
        "JetBrainsMono-Regular",
        "JetBrainsMono-Medium",
        "M+1CodeNerdFontMono-Medium",
    ]

    for font in required_fonts:
        if not has_font(font):
            unsatisfied_font_warning(font)


def install_dependencies(runtime: str) -> None:
    scripts = [
        f"{runtime}/scripts/install-deps.sh",
        f"{runtime}/scripts/install-lsps.sh",
    ]

    for script in scripts:
        subprocess.run(["bash", "-c", script])


def unsatisfied_font_warning(required_font: str) -> None:
    print(f"Warning: You do not have {required_font} installed")
    print("NovaVim might not work as expected")
    print("Do you wish to proceed?")

    user_feedback = input("(y/n)")
    if user_feedback[0].lower() == "y":
        return

    sys.exit(UNSATISFIED_DEPENDENCY_ERROR)


def init_module(runtime: str) -> str:
    return f"""
package.path = '{runtime}/?.lua;'..package.path
package.path = '{runtime}/modules/?.lua;'..package.path
require('setup')
"""


def main() -> None:
    bin_target = "/usr/local/bin/2nvim"
    runtime = os.path.dirname(os.path.realpath(__file__))
    starter_path = runtime + "/start.sh"
    init_module_path = runtime + "/init.lua"

    if os.path.exists(bin_target):
        print("Removing old 2nvim install")
        os.remove(bin_target)

    starter_template = ""
    if is_wsl():
        starter_template = wsl_starter(runtime)
    elif has_neovide():
        starter_template = neovide_starter(runtime)
    elif has_alacritty():
        alacritty_version = subprocess.check_output(["alacritty", "--version"]).decode("utf-8")
        [major, minor, patch] = alacritty_version.split(".")
        [_program_name, major] = major.split(" ")

        # full support for toml configs was added in version 0.4
        if int(major) <= 0 and int(minor) < 14:
            starter_template = yaml_alacritty_starter(runtime)
        else:
            starter_template = alacritty_starter(runtime)
    elif has_xterm():
        starter_template = xterm_starter(runtime)
    else:
        print("You do not have a supported terminal emulator installed")
        print("Supported terminals: Alacritty, XTerm, WSL")
        sys.exit(UNSATISFIED_DEPENDENCY_ERROR)

    # I purposely install dependencies after installing fonts so that you get
    # unrecoverable errors sooner
    check_required_fonts()
    install_dependencies(runtime)

    with open(starter_path, "w") as file:
        file.write(starter_template)

    init_module_template = init_module(runtime)
    with open(init_module_path, "w") as file:
        file.write(init_module_template)

    starter_perms = os.stat(starter_path).st_mode
    new_starter_perms = starter_perms | stat.S_IXUSR

    print(f"Creating symlink in {starter_path}")
    os.chmod(starter_path, new_starter_perms)
    os.symlink(starter_path, bin_target)
    os.chmod(bin_target, new_starter_perms)


if __name__ == "__main__":
    main()
