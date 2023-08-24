import revisionOperatorsUtils
import propositionalLogic
import types
import sequtils

proc revision1*[T](
  config: RevisionOperatorConfig[T],
  self: PropLogicFormula,
  context: seq[PropLogicFormula]
): PropLogicFormula =
  delta[T](config, self, context, interpretations().toSeq())

proc revision3*[T](
  config: RevisionOperatorConfig[T],
  self: PropLogicFormula,
  context: seq[PropLogicFormula],
): PropLogicFormula =
  delta[T](config, self, context.concat(@[self]), interpretations().toSeq())