from __future__ import annotations

from typing import Callable, Any, Dict, List, Type


class Hookable:
    """
    A hook in a class C is a function that can be called
    statically by C.run_hooks(hook_name, ...) inside C
    """

    hooks: Dict[str, List[Callable[..., None]]]

    @staticmethod
    def get_hooks(cls_obj: Type[Hookable]) -> Dict[str, List[Callable[..., None]]]:
        hooks = getattr(cls_obj, f"__{cls_obj.__name__}_hooks__", None)

        if hooks is None:
            hooks = {}
            setattr(cls_obj, f"__{cls_obj.__name__}_hooks__", hooks)

        return hooks  # type: ignore

    @classmethod
    def add_hook(cls, name: str) -> Callable[[Callable[..., Any]], Callable[..., Any]]:
        def decorator(func: Callable[..., Any]) -> Callable[..., Any]:
            hooks = Hookable.get_hooks(cls)

            if name not in hooks:
                hooks[name] = []

            hooks[name].append(func)
            return func

        return decorator

    @classmethod
    def run_hooks(cls, name: str, *args: Any, **kwargs: Any) -> None:
        hooks = Hookable.get_hooks(cls)

        if name in hooks:
            for hook in hooks[name]:
                hook(*args, **kwargs)
