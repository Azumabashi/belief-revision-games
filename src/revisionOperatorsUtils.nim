import propositionalLogic
import types
import sequtils
import algorithm
import tables

proc dist[T](
  config: RevisionOperatorConfig[T],
  omega: Interpretation,
  formula: PropLogicFormula,
): float =
  var minDist = high(float)
  for interpretation in interpretations():
    if not formula.isSat(interpretation):
      continue
    minDist = min(minDist, config.distance(omega, interpretation))
  return minDist

proc df[T](
  config: RevisionOperatorConfig[T],
  omega: Interpretation,
  contexts: seq[PropLogicFormula],
): T =
  config.filter(contexts.mapIt(dist[T](config, omega, it)))

proc generateLiteral(id: int, negation: bool = false): PropLogicFormula =
  result = generateAtomicPropWithGivenId(id)
  if negation:
    result = !result

proc delta*[T](
  config: RevisionOperatorConfig[T],
  self: PropLogicFormula,
  contexts: seq[PropLogicFormula],
  models: seq[Interpretation]
): PropLogicFormula =
  if contexts.len == 0:
    return self
  let 
    choicedModel = models.sorted(
      proc (x, y: Interpretation): int = config.cmp(
        df[T](config, x, contexts),
        df[T](config, y, contexts),
      )
    )[models.len - 1]
    currentAtoms = choicedModel.keys.toSeq.mapIt(
      generateLiteral(it, choicedModel[it] == TOP)
    )
  currentAtoms[1..<currentAtoms.len].foldl(
    (a & b),
    currentAtoms[0]
  )