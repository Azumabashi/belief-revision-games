import revisionOperatorsUtils
import propositionalLogic
import math
import types
import distance

proc revision3*(self: PropLogicFormula, context: seq[PropLogicFormula], interpretations: seq[Interpretation]): PropLogicFormula =
  let config = RevisionOperatorConfig[float](
    distance: drasticDistance,
    filter: proc(x: seq[float]): float = x.sum,
    cmp: cmp
  )
  delta[float](config, self, context, interpretations)