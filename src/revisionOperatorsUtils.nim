import propositionalLogic
import types
import sequtils
import algorithm

proc dist[T](
  config: RevisionOperatorConfig[T],
  omega: Interpretation,
  formula: PropLogicFormula,
  interpretations: seq[Interpretation]
): float =
  var dists = interpretations.filterIt(formula.isSat(it)).mapIt(config.distance(omega, it))
  dists.sort(config.cmp)
  return dists[0]

proc df[T](
  config: RevisionOperatorConfig[T],
  omega: Interpretation,
  contexts: seq[PropLogicFormula],
  interpretations: seq[Interpretation]
): seq[T] =
  contexts.mapIt(dist[T](dist, omega, it, interpretations)).filter()

proc delta*[T](
  config: RevisionOperatorConfig[T],
  self: PropLogicFormula,
  contexts: seq[PropLogicFormula],
  interpretations: seq[Interpretation]
): PropLogicFormula =
  if contexts.len == 0:
    return self
  var models = self.getModels(interpretations)
  models.sort(
    proc (x, y: Interpretation): int = config.cmp(
      df[T](config, x, contexts, interpretations),
      df[T](config, y, contexts, interpretations),
    )
  )
  # ToDo: returns one of the formulae satisfied by an interpretation