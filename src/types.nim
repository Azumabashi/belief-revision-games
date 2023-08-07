import propositionalLogic

type
  Agent* = object
    id*: int
    belief*: PropLogicFormula
  BeliefRevisionGame* = object
    agents*: seq[Agent]
    connection*: seq[seq[bool]]
    atomicFormulae*: seq[PropLogicFormula]
    revisionOperators*: seq[proc (self: PropLogicFormula, context: seq[PropLogicFormula]): PropLogicFormula]