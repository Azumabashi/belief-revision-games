import unittest
import propositionalLogic
import beliefRevisionGames

suite "test for preset configs":
  let 
    a = generateAtomicProp()
    b = generateAtomicProp()
    K1 = a & b
    K2 = !a & !b
    K3 = !a & !b
    mu = a | b
    profile = @[K1, K2, K3]
  
  test "summention":
    let
      config = summentionConfig(hammingDistance)
      expected = (a & !b) | (!a & b)
      newBelief = delta[float](config, mu, profile, mu.getModels())
    echo newBelief
    check ((expected => newBelief) & (newBelief => expected)).isTautology()
  
  test "GMin":
    let 
      config = gminConfig(hammingDistance)
      expected = a & b
      newBelief = delta[seq[float]](config, mu, profile, mu.getModels())
    check ((expected => newBelief) & (newBelief => expected)).isTautology()