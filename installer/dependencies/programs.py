from util import has_application

def has_ripgrep() -> bool:
    return has_application("rg")
