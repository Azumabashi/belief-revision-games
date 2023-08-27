import unittest
import propositionalLogic
import beliefRevisionGames

suite "test for revision6":
  let 
    s = generateAtomicProp()
    b = generateAtomicProp()
    q = generateAtomicProp()
    config = summentionConfig(hammingDistance)
    alice = !s & b
    bob = s & (b => q)
    charles = !s
  
  test "revision by revision6 for alice":
    let
      belief = alice
      context = @[bob]
      newBelief = revision6[float](config, belief, context)
      expected = !s & b & q
    check ((newBelief => expected) & (expected => newBelief)).isTautology()
  
  test "revision by revision6 for bob":
    let 
      belief = bob
      context = @[alice, charles]
      newBelief = revision6[float](config, belief, context)
      expected = s & b & q
    check ((newBelief => expected) & (expected => newBelief)).isTautology()

  test "revision by revision6 for charles":
    let 
      belief = charles
      context = @[bob]
      newBelief = revision6[float](config, belief, context)
      expected = (!s & b & q) | (!s & !b)
    check ((newBelief => expected) & (expected => newBelief)).isTautology()