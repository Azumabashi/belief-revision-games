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

proc revision2*[T](
  config: RevisionOperatorConfig[T],
  self: PropLogicFormula,
  context: seq[PropLogicFormula]
): PropLogicFormula =
  let mu = delta[T](config, self, context, interpretations().toSeq())
  delta[T](config, mu, self, mu.getModels())

proc revision3*[T](
  config: RevisionOperatorConfig[T],
  self: PropLogicFormula,
  context: seq[PropLogicFormula],
): PropLogicFormula =
  delta[T](config, self, context.concat(@[self]), interpretations().toSeq())

proc revision4*[T](
  config: RevisionOperatorConfig[T],
  self: PropLogicFormula,
  context: seq[PropLogicFormula]
): PropLogicFormula =
  let mu = delta[T](config, self, context, interpretations().toSeq())
  delta[T](config, self, @[self, mu], interpretations().toSeq())