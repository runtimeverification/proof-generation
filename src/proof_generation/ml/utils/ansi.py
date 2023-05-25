from typing import List, Any, Callable

import os
import sys


class ANSIStyler(type):
    RESET = "\033[0m"
    """
    name -> (foreground code, background code)
    """
    COLOR_CODES = {
        "black": (30, 40),
        "red": (31, 41),
        "green": (32, 42),
        "yellow": (33, 43),
        "blue": (34, 44),
        "magenta": (35, 45),
        "cyan": (36, 46),
        "white": (37, 47),
        "gray": (90, 100),
        "bright_red": (91, 101),
        "bright_green": (92, 102),
        "bright_yellow": (93, 103),
        "bright_blue": (94, 104),
        "bright_magenta": (95, 105),
        "bright_cyan": (96, 106),
        "bright_white": (97, 107),
    }

    STYLE_CODES = {
        "reset": 0,
        "bold": 1,
        "italic": 3,
    }

    def get_code(class_obj, styles: List[str]) -> str:
        """
        Supported combinations:
            - <color> - single foreground color
            - <color> <color> - foreground background
            - <style> - single style
        """

        styles = list(styles)

        codes = []
        i = 0

        while i < len(styles):
            style = styles[i]

            if style == "rgb" and i + 4 < len(styles):
                kind = styles[i + 1]
                assert kind == "fg" or kind == "bg", \
                       f"invalid kind {kind}"

                r = int(styles[i + 2])
                g = int(styles[i + 3])
                b = int(styles[i + 4])
                i += 5

                if ANSI.supports_true_color():
                    codes.append(f"\033[{38 if kind == 'fg' else 48};2;{r};{g};{b}m")

                continue

            # special case for bright_* colors
            if style == "bright" and i + 1 < len(styles):
                styles[i + 1] = "bright_" + styles[i + 1]
                i += 1
                continue

            if style in ANSIStyler.COLOR_CODES:
                if i + 1 < len(styles):
                    next_style = styles[i + 1]
                    if style in ANSIStyler.COLOR_CODES:
                        # foregound and background
                        codes.append(
                            f"\033[{ANSIStyler.COLOR_CODES[style][0]};{ANSIStyler.COLOR_CODES[next_style][1]}m"
                        )
                        i += 2
                        continue

                # otherwise use single foreground color
                codes.append(f"\033[{ANSIStyler.COLOR_CODES[style][0]}m")
            else:
                assert style in ANSIStyler.STYLE_CODES, f"ANSI style {style} not found"
                codes.append(f"\033[{ANSIStyler.STYLE_CODES[style]}m")

            i += 1

        return "".join(codes)

    def __getattr__(class_obj, key: str) -> Any:
        if key.startswith("in_"):
            styles = key[len("in_"):].split("_")

            def f(msg: str) -> str:
                if not ANSI.supports_color():
                    return msg
                return f"{class_obj.get_code(styles)}{msg}{ANSIStyler.RESET}"

            return f

        raise AttributeError(key)


class ANSI(metaclass=ANSIStyler):
    Colorizer = Callable[[str], str]

    @staticmethod
    def supports_color() -> bool:
        """
        Returns True if the running system's terminal supports color, and False
        otherwise.

        Adapted from: https://github.com/django/django/blob/main/django/core/management/color.py
        """
        plat = sys.platform
        supported_platform = plat != "Pocket PC" and (plat != "win32" or "ANSICON" in os.environ)
        # isatty is not always implemented, #6223.
        is_a_tty = hasattr(sys.stdout, "isatty") and sys.stdout.isatty()
        return supported_platform and is_a_tty

    @staticmethod
    def supports_true_color() -> bool:
        colorterm = os.environ.get("COLORTERM", "")
        return "truecolor" in colorterm or "24bit" in colorterm
