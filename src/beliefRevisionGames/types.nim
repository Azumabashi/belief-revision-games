import propositionalLogic

type
  Agent* = object
    id*: int
    belief*: PropLogicFormula
  BeliefRevisionGame*[T] = object
    agents*: seq[Agent]
    connection*: seq[seq[int]]
    revisionOperators*: seq[proc (config: RevisionOperatorConfig[T], self: PropLogicFormula, context: seq[PropLogicFormula]): PropLogicFormula {.nimcall.}]
  RevisionOperatorConfig*[T] = object
    distance*: proc(x, y: Interpretation): float
    filter*: proc(x: seq[float]): T
    cmp*: proc(x, y: T): int