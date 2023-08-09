import propositionalLogic
import types
import sequtils
import algorithm
import tables

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
): T =
  config.filter(contexts.mapIt(dist[T](config, omega, it, interpretations)))

proc delta*[T](
  config: RevisionOperatorConfig[T],
  self: PropLogicFormula,
  contexts: seq[PropLogicFormula],
  interpretations: seq[Interpretation],
  allFormulae: seq[PropLogicFormula]
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
  let 
    choicedModel = models[models.len - 1]
    currentAtoms = choicedModel.keys.toSeq.mapIt(
      if choicedModel[it] == TOP: allFormulae[it] else: !allFormulae[it]
    )
  currentAtoms[1..<currentAtoms.len].foldl(
    (a & b),
    currentAtoms[0]
  )