import shutil

def has_application(name: str) -> bool:
    return shutil.which("xterm") is not None
