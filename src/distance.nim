import propositionalLogic

proc drasticDistance*(x, y: PropLogicFormula): int =
  if x == y: 0 else: 1