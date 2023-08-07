import propositionalLogic
import types
import sequtils
import algorithm

proc dist(
  config: RevisionOperatorConfig,
  omega: Interpretation,
  formula: PropLogicFormula,
  interpretations: seq[Interpretation]
): float =
  var dists = interpretations.filterIt(formula.isSat(it)).mapIt(config.distance(omega, it))
  dists.sort(config.cmp)
  return dists

proc df[T](
  config: RevisionOperatorConfig,
  omega: Interpretation,
  contexts: seq[PropLogicFormula],
  interpretations: seq[Interpretation]
): seq[T] =
  contexts.mapIt(config.dist(omega, it, interpretations)).filter()

proc delta(
  config: RevisionOperatorConfig,
  self: PropLogicFormula,
  contexts: seq[PropLogicFormula],
  interpretations: seq[Interpretation]
): PropLogicFormula =
  if contexts.len == 0:
    return self
  var models = self.getModels(interpretations)
  models.sort(
    proc (x, y: Interpretation): int = config.cmp(
      config.df(x, contexts, interpretations),
      config.df(y, contexts, interpretations),
    )
  )
  # ToDo: returns one of the formulae satisfied by an interpretation