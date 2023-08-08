import propositionalLogic

proc drasticDistance*(x, y: Interpretation): float =
  if x == y: 0.0 else: 1.0