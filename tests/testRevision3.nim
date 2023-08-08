import unittest
import propositionalLogic
import revisionOperators

suite "test for revision3":
  setup:
    let 
      (allFormulae, allInterpretations) = init(3)
      s = allFormulae[0]
      b = allFormulae[1]
      q = allFormulae[2]
  
  test "revision by revision3":
    let 
      belief = s & (b => q)
      context = @[(!s) & b, !s]
      newBelief = belief.revision3(context, allInterpretations, allFormulae)
    echo newBelief
