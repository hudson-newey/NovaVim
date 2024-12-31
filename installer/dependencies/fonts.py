from constants.errors import UNSATISFIED_DEPENDENCY_ERROR

def check_required_fonts() -> None:
    required_fonts = ["JetBrainsMono-Medium", "M+1CodeNerdFontMono-Medium"]

    for font in required_fonts:
        if not _has_font(font):
            _unsatisfied_font_warning(font)

def _has_font(font: str) -> bool:
try:
    output = subprocess.check_output(["fc-list", font])
    if output == b"":
        return False
except Exception:
    return False

return True

def _unsatisfied_font_warning(required_font: str) -> None:
    print(f"Warning: You do not have {required_font} installed")
    print("NovaVim might not work as expected");
    print("Do you wish to proceed?")

    user_feedback = input("(y/n)")
    if user_feedback[0].lower() == "y":
        return

    os.exit(UNSATISFIED_DEPENDENCY_ERROR)


