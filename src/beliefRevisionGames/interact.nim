import types
import sequtils

proc interact*[T](G: BeliefRevisionGame, config: RevisionOperatorConfig[T]): BeliefRevisionGame =
  var nextAgents: seq[BRGAgent] = @[]
  for agentId in 0..<G.agents.len:
    let 
      context = G.connection[agentId].mapIt(G.agents[it].belief)
      operator = G.revisionOperators[agentId]
    nextAgents.add(BRGAgent(
      id: agentId,
      belief : operator(config, G.agents[agentId].belief, context)
    ))
  BeliefRevisionGame(
    agents: nextAgents,
    connection: G.connection,
    revisionOperators: G.revisionOperators
  )