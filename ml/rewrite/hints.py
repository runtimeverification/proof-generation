from __future__ import annotations

from typing import Mapping, List, Optional, Any, Dict

import schema  # type: ignore

from ml.kore import ast as kore
from ml.kore.parser import parse_pattern


class RewritingHints:
    """
    Hints generated by backends to aid rewriting proof gen
    """

    def __init__(
        self, substitutions: List[Optional[Mapping[kore.Variable, kore.Pattern]]]
    ):
        self.substitutions = substitutions

    def get_substitution_for_step(
        self, i: int
    ) -> Optional[Mapping[kore.Variable, kore.Pattern]]:
        if i < len(self.substitutions):
            return self.substitutions[i]
        else:
            return None

    @staticmethod
    def load_from_object(module: kore.Module, obj: Dict[str, Any]) -> RewritingHints:
        validated = schema.Schema(
            {
                "type": "rewriting",
                schema.Optional("actions"): [
                    schema.Or(
                        {
                            "type": "step",
                            schema.Optional("rule-id"): str,
                            schema.Optional("substitution"): [
                                {
                                    "key": schema.And(
                                        str,
                                        schema.Use(
                                            lambda key: parse_pattern(key, module)
                                        ),
                                    ),
                                    "value": schema.And(
                                        str,
                                        schema.Use(
                                            lambda val: parse_pattern(val, module)
                                        ),
                                    ),
                                }
                            ],
                        }
                    )
                ],
            }
        ).validate(obj)

        substitutions: List[Optional[Mapping[kore.Variable, kore.Pattern]]] = [
            {item["key"]: item["value"] for item in action.get("substitution", [])}
            for action in validated.get("actions", [])
        ]
        return RewritingHints(substitutions)
