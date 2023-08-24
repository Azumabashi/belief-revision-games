import unittest
import propositionalLogic
import beliefRevisionGames
import math

suite "test for revision1":
  let 
    s = generateAtomicProp()
    b = generateAtomicProp()
    q = generateAtomicProp()
    config = summentionConfig(hammingDistance)
    alice = !s & b
    bob = s & (b => q)
    charles = !s
  
  test "revision by revision1 for alice":
    let
      belief = alice
      context = @[bob]
      newBelief = revision1[float](config, belief, context)
      expected = (s & !b) | (s & q)  # ToDo: check whether this is correct or not
    check ((newBelief => expected) & (expected => newBelief)).isTautology()
  
  test "revision by revision1 for bob":
    let 
      belief = bob
      context = @[alice, charles]
      newBelief = revision1[float](config, belief, context)
      expected = !s & b  # ToDo: check whether this is correct or not
    check ((newBelief => expected) & (expected => newBelief)).isTautology()

  test "revision by revision1 for charles":
    let 
      belief = charles
      context = @[bob]
      newBelief = revision1[float](config, belief, context)
      expected = (s & !b) | (s & q) # ToDo: check whether this is correct or not
    check ((newBelief => expected) & (expected => newBelief)).isTautology()