import propositionalLogic
import types
import revisionOperators
import distance
import interact
import sequtils
import math

const
  connection = @[
    @[1],
    @[0, 2],
    @[1]
  ]
let
  (formulae, allInterpretations) = init(3)
  s = formulae[0]
  b = formulae[1]
  q = formulae[2]
  alice = Agent(
    id: 0,
    belief: (!s) & b
  )
  bob = Agent(
    id: 1,
    belief: s & (b => q)
  )
  charlie = Agent(
    id: 2,
    belief: !s
  )
  config = RevisionOperatorConfig[float](
    distance: hammingDistance,
    filter: proc(x: seq[float]): float = x.sum,
    cmp: cmp
  )
var
  G = BeliefRevisionGame[float](
    agents: @[alice, bob, charlie],
    connection: connection,
    atomicFormulae: formulae,
    revisionOperators: @[revision3[float], revision3[float], revision3[float]]
  )
for _ in 0..<5:
  G = G.interact(config, allInterpretations)
  echo G.agents.mapIt(it.belief)