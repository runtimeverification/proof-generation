from __future__ import annotations

from typing import Mapping, List, Optional, Any, Dict

import schema  # type: ignore

from ml.kore import ast as kore
from ml.kore.parser import parse_pattern

from .templates import KoreTemplates


class RewritingStep:
    """
    Hints for a rewriting step, with the following fields
      - expected initial term (optional)
      - rewriting rule used (optional)
      - substitution used (optional)
    """
    def __init__(
        self,
        initial: Optional[kore.Pattern] = None,
        rule_id: Optional[str] = None,
        substitution: Optional[Mapping[kore.Variable, kore.Pattern]] = None,
    ):
        self.initial = initial
        self.rule_id = rule_id
        self.substitution = substitution


class RewritingTask:
    """
    Rewriting task aims to prove a rewriting claim
    """
    def __init__(
        self,
        initial: kore.Pattern,
        final: kore.Pattern,
        steps: List[RewritingStep],
    ):
        self.initial = initial
        self.final = final
        self.steps = steps

    @staticmethod
    def load_from_object(module: kore.Module, obj: Dict[str, Any]) -> RewritingTask:
        parse = lambda src: parse_pattern(src, module)
        parse_and_strip_inj = lambda src: KoreTemplates.strip_inj(parse(src))

        validated = schema.Schema(
            {
                "task": "rewriting",
                "initial": schema.And(
                    str,
                    schema.Use(parse_and_strip_inj),
                ),
                "final": schema.And(
                    str,
                    schema.Use(parse_and_strip_inj),
                ),
                schema.Optional("steps"): [
                    schema.Or(
                        {
                            "type": "rewriting",
                            schema.Optional("from"): schema.And(str, schema.Use(parse_and_strip_inj)),
                            schema.Optional("rule-id"): str,
                            schema.Optional("substitution"): [
                                {
                                    "key": schema.And(
                                        str,
                                        schema.Use(parse),
                                    ),
                                    "value": schema.And(
                                        str,
                                        schema.Use(parse),
                                    ),
                                }
                            ],
                        }
                    )
                ],
            }
        ).validate(obj)

        # construct each step from validated object
        steps = []
        for step_obj in validated.get("steps", []):
            substitution: Optional[Mapping[kore.Variable, kore.Pattern]] = None

            if "substitution" in step_obj:
                substitution = {}
                for item in step_obj["substitution"]:
                    substitution[item["key"]] = item["value"]

            step = RewritingStep(step_obj.get("from"), step_obj.get("rule-id"), substitution)
            steps.append(step)

        return RewritingTask(validated["initial"], validated["final"], steps)
