import unittest
import propositionalLogic
import revisionOperators
import types
import distance
import math

suite "test for revision3":
  setup:
    let 
      (allFormulae, allInterpretations) = init(3)
      s = allFormulae[0]
      b = allFormulae[1]
      q = allFormulae[2]
      config = RevisionOperatorConfig[float](
        distance: hammingDistance,
        filter: proc(x: seq[float]): float = x.sum,
        cmp: cmp
      )
  
  test "revision by revision3":
    let 
      belief = s & (b => q)
      context = @[(!s) & b, !s]
      newBelief = config.revision3(belief, context, allInterpretations, allFormulae)
    echo newBelief
