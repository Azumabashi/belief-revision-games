import beliefRevisionGames/types
import beliefRevisionGames/revisionOperators
import beliefRevisionGames/revisionOperatorsUtils
import beliefRevisionGames/distance
import beliefRevisionGames/interact
import beliefRevisionGames/configs

export
  drasticDistance, hammingDistance,
  interact,
  revision1, revision2, revision3, revision4, revision5, revision6,
  delta,
  BRGAgent, BeliefRevisionGame, RevisionOperatorConfig,
  summentionConfig, gminConfig

runnableExamples:
  import propositionalLogic
  import sequtils
  import math
  import beliefRevisionGames
  
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
    alice = BRGAgent(
      id: 0,
      belief: (!s) & b
    )
    bob = BRGAgent(
      id: 1,
      belief: s & (b => q)
    )
    charlie = BRGAgent(
      id: 2,
      belief: !s
    )
    config = summentionConfig(hammingDistance)
  var
    G = BeliefRevisionGame[float](
      agents: @[alice, bob, charlie],
      connection: connection,
      revisionOperators: @[revision3[float], revision3[float], revision3[float]]
    )
  for _ in 0..<5:
    G = G.interact(config)
    echo G.agents.mapIt(it.belief)