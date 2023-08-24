import types
import propositionalLogic
import math
import algorithm

proc summentionConfig*(distance: proc(x, y: Interpretation): float): RevisionOperatorConfig[float] =
  RevisionOperatorConfig[float](
    distance: distance,
    filter: proc(x: seq[float]): float = x.sum,
    cmp: cmp
  )

proc gminConfig*(distance: proc(x, y: Interpretation): float): RevisionOperatorConfig[seq[float]] =
  RevisionOperatorConfig[seq[float]](
    distance: distance,
    filter: proc(x: seq[float]): seq[float] = x.sorted(),
    cmp: proc (x, y: seq[float]): int =
      for i in 0..<x.len:
        if x[i] > y[i]: return 1
        elif x[i] == y[i]: continue
        else: return -1
  )