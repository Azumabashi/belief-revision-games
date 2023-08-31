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

proc interpretationToFormula(interpretation: Interpretation): PropLogicFormula =
  var formulae: seq[PropLogicFormula] = @[]
  for atomicProposition in interpretation.keys():
    let formula = generateAtomicPropWithGivenId(atomicProposition.getId())
    formulae.add(if interpretation[atomicProposition] == TOP: formula else: !formula)
  formulae.foldl(a & b)

proc delta*[T](
  config: RevisionOperatorConfig[T],
  self: PropLogicFormula,
  contexts: seq[PropLogicFormula],
  models: seq[Interpretation]
): PropLogicFormula =
  if contexts.len == 0:
    return self
  var
    dfInterpretationPairs = models.mapIt((df[T](config, it, contexts), it))
  dfInterpretationPairs.sort(proc (x, y: (T, Interpretation)): int = config.cmp(x[0], y[0]))
  let
    choicedFormula = dfInterpretationPairs.filterIt(
      it[0] == dfInterpretationPairs[0][0]
    ).mapIt(it[1].interpretationToFormula())
  choicedFormula.foldl(a | b).simplification()