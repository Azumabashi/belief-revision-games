import propositionalLogic
import belief_revision_games/types
import belief_revision_games/revisionOperators
import belief_revision_games/revisionOperatorsUtils
import belief_revision_games/distance
import belief_revision_games/interact
import sequtils
import math

export
  drasticDistance, hammingDistance,
  interact,
  revision1, revision2, revision3, revision4, revision5, revision6,
  delta,
  Agent, BeliefRevisionGame, RevisionOperatorConfig

const
  connection = @[
    @[1],
    @[0, 2],
    @[1]
  ]
let
  s = generateAtomicProp()
  b = generateAtomicProp()
  q = generateAtomicProp()
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
    revisionOperators: @[revision3[float], revision3[float], revision3[float]]
  )
for _ in 0..<5:
  G = G.interact(config)
  echo G.agents.mapIt(it.belief)