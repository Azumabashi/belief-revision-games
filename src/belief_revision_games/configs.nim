import types
import propositionalLogic
import math

proc summentionConfig*(distance: proc(x, y: Interpretation): float): RevisionOperatorConfig[float] =
  RevisionOperatorConfig[float](
    distance: distance,
    filter: proc(x: seq[float]): float = x.sum,
    cmp: cmp
  )