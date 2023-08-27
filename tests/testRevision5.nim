import unittest
import propositionalLogic
import beliefRevisionGames
import math

suite "test for revision5":
  let 
    s = generateAtomicProp()
    b = generateAtomicProp()
    q = generateAtomicProp()
    config = summentionConfig(hammingDistance)
    alice = !s & b
    bob = s & (b => q)
    charles = !s
  
  test "revision by revision5 for alice":
    let
      belief = alice
      context = @[bob]
      newBelief = revision5[float](config, belief, context)
      expected = !s & b & q
    check newBelief.iff(expected)
  
  test "revision by revision5 for bob":
    let 
      belief = bob
      context = @[alice, charles]
      newBelief = revision5[float](config, belief, context)
      expected = s & b & q
    check newBelief.iff(expected)

  test "revision by revision5 for charles":
    let 
      belief = charles
      context = @[bob]
      newBelief = revision5[float](config, belief, context)
      expected = (!s & b & q) | (!s & !b)
    check newBelief.iff(expected)