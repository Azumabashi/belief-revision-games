import propositionalLogic

type
  Agent* = object
    id*: int
    belief*: PropLogicFormula
  BeliefRevisionGame* = object
    agents*: seq[Agent]
    connection*: seq[seq[bool]]
    atomicFormulae*: seq[PropLogicFormula]
    revisionOperators*: seq[proc (self: PropLogicFormula, context: seq[PropLogicFormula], interpretations: seq[Interpretation]): PropLogicFormula]
  RevisionOperatorConfig*[T] = object
    distance*: proc(x, y: PropLogicFormula): float
    filter*: proc(x: seq[float]): T
    cmp*: proc(x, y: T): int