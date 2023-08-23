import unittest
import propositionalLogic
import revisionOperators
import types
import distance
import math

suite "test for revision3":
  setup:
    let 
      s = generateAtomicProp()
      b = generateAtomicProp()
      q = generateAtomicProp()
      config = RevisionOperatorConfig[float](
        distance: hammingDistance,
        filter: proc(x: seq[float]): float = x.sum,
        cmp: cmp
      )
  
  test "revision by revision3":
    let 
      belief = s & (b => q)
      context = @[(!s) & b, !s]
      newBelief = revision3[float](config, belief, context)
    # ToDo: compare `newBelief` with ((q & s) & (!b))
    # This should be equal to ((q & s) & (!b)), but proc `==` between PropLogicFormula is not implemented yet.
    echo newBelief
