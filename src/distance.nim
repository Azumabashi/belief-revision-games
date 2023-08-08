import propositionalLogic
import tables
import sequtils

proc drasticDistance*(x, y: Interpretation): float =
  if x == y: 0.0 else: 1.0

proc hammingDistance*(x, y: Interpretation): float = 
  let keys = x.keys.toSeq
  for key in keys:
    if x[key] != y[key]:
      result += 1
  return result.float