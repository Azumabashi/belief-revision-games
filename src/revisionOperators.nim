import revisionOperatorsUtils
import propositionalLogic
import types

proc revision3*[T](
  config: RevisionOperatorConfig[T],
  self: PropLogicFormula,
  context: seq[PropLogicFormula],
  interpretations: seq[Interpretation],
  allFormulae: seq[PropLogicFormula]
): PropLogicFormula =
  delta[T](config, self, context, interpretations, allFormulae)