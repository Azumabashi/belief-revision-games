import revisionOperatorsUtils
import propositionalLogic
import types
import sequtils

proc revision3*[T](
  config: RevisionOperatorConfig[T],
  self: PropLogicFormula,
  context: seq[PropLogicFormula],
): PropLogicFormula =
  delta[T](config, self, context, interpretations().toSeq())