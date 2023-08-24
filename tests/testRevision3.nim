import unittest
import propositionalLogic
import beliefRevisionGames
import math

suite "test for revision3":
  let 
    s = generateAtomicProp()
    b = generateAtomicProp()
    q = generateAtomicProp()
    config = summentionConfig(hammingDistance)
    alice = !s & b
    bob = s & (b => q)
    charles = !s
  
  test "revision by revision3 for alice":
    let
      belief = alice
      context = @[bob]
      newBelief = revision3[float](config, belief, context)
      expected = b & q
    check ((newBelief => expected) & (expected => newBelief)).isTautology()
  
  test "revision by revision3 for bob":
    let 
      belief = bob
      context = @[alice, charles]
      newBelief = revision3[float](config, belief, context)
      expected = ((!s & b) & q)
    check ((newBelief => expected) & (expected => newBelief)).isTautology()

  test "revision by revision3 for charles":
    let 
      belief = charles
      context = @[bob]
      newBelief = revision3[float](config, belief, context)
      expected = b => q
    check ((newBelief => expected) & (expected => newBelief)).isTautology()