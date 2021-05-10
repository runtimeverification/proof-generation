from typing import Any, List


class Visitor:
    """
    A general visitor base class
    """
    def previsit_default(self, x: Any) -> Any:
        return x

    def visit_children_of_default(self, x: Any) -> List[Any]:
        return []

    def postvisit_default(self, x: Any, *args: Any) -> Any:
        return x

    def visit(self, x: Any) -> Any:
        return x.visit(self)

    def __getattr__(self, name: str) -> Any:
        """
        When a node.visit is called, proxy_visit_* will be called first, which will:
        1. call previsit_*
        2. call visit_children_of_* to visit all children
        3. call postvisit_* (with return values of the children visits)
        """
        if name.startswith("previsit_"):
            return self.previsit_default
        elif name.startswith("visit_children_of_"):
            return self.visit_children_of_default
        elif name.startswith("postvisit_"):
            return self.postvisit_default
        elif name.startswith("proxy_visit_"):
            name = name[12:]

            def f(node: Any) -> Any:
                getattr(self, "previsit_" + name)(node)
                children = getattr(self, "visit_children_of_" + name)(node)
                return getattr(self, "postvisit_" + name)(node, *children)

            return f
        else:
            raise AttributeError(name)
