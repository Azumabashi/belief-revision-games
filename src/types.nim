import propositionalLogic

type
  Agent* = object
    id*: int
    belief*: PropLogicFormula