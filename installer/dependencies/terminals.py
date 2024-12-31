from util import has_application

def has_alacritty() -> bool:
    return has_application("alacritty")


def has_xterm() -> bool:
    return has_application("xterm")
