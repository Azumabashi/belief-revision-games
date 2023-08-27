import unittest
import propositionalLogic
import beliefRevisionGames
import math

suite "test for drastic distance":
  let 
    s = generateAtomicProp()
    b = generateAtomicProp()
    q = generateAtomicProp()
    config = summentionConfig(drasticDistance)
    alice = !s & b
    bob = s & (b => q)
    charles = !s
  
  test "revision by drastic distance for alice":
    let
      belief = alice
      context = @[bob]
      newBelief = revision3[float](config, belief, context)
      expected = !((s & b & !q) | (!s & !b))
    check newBelief.iff(expected)
  
  test "revision by drastic distance for bob":
    let 
      belief = bob
      context = @[alice, charles]
      newBelief = revision3[float](config, belief, context)
      expected = !s & b
    check newBelief.iff(expected)

  test "revision by drastic distance for charles":
    let 
      belief = charles
      context = @[bob]
      newBelief = revision3[float](config, belief, context)
      expected = !(s & b & !q)
    check newBelief.iff(expected)