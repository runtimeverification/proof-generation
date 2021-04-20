from typing import List

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

        codes = []
        i = 0

        while i < len(styles):
            style = styles[i]

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

    def __getattr__(class_obj, key: str):
        if key.startswith("in_"):
            styles = key[len("in_"):].split("_")

            def f(msg: str) -> str:
                if not ANSIStyler.supports_color():
                    return msg
                return f"{class_obj.get_code(styles)}{msg}{ANSIStyler.RESET}"

            return f

        raise AttributeError(key)


class ANSI(metaclass=ANSIStyler):
    pass
