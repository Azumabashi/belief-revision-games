import propositionalLogic

proc drasticDistance*(x, y: PropLogicFormula): float =
  if x == y: 0.0 else: 1.0