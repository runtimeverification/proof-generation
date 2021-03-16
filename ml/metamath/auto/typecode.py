from typing import Optional

from ..ast import Metavariable, Term, Statement, Application, StructuredStatement
from ..visitors import SubstitutionVisitor

from .unification import Unification


