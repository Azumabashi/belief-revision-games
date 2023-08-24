import unittest
import propositionalLogic
import belief_revision_games
import math

suite "test for drastic distance":
  let 
    s = generateAtomicProp()
    b = generateAtomicProp()
    q = generateAtomicProp()
    config = RevisionOperatorConfig[float](
      distance: drasticDistance,
      filter: proc(x: seq[float]): float = x.sum,
      cmp: cmp
    )
    alice = !s & b
    bob = s & (b => q)
    charles = !s
  
  test "revision by drastic distance for alice":
    let
      belief = alice
      context = @[bob]
      newBelief = revision3[float](config, belief, context)
      expected = (s & !b) | (!s & b) | (s & q) | (b & q)   # ToDo: check whether this is correct or not
    check ((newBelief => expected) & (expected => newBelief)).isTautology()
  
  test "revision by drastic distance for bob":
    let 
      belief = bob
      context = @[alice, charles]
      newBelief = revision3[float](config, belief, context)
      expected = !s & b  # ToDo: check whether this is correct or not
    check ((newBelief => expected) & (expected => newBelief)).isTautology()

  test "revision by drastic distance for charles":
    let 
      belief = charles
      context = @[bob]
      newBelief = revision3[float](config, belief, context)
      expected = !s | !b | q  # ToDo: check whether this is correct or not
    check ((newBelief => expected) & (expected => newBelief)).isTautology()