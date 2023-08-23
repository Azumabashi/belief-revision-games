import types
import sequtils
import propositionalLogic

proc interact*[T](G: BeliefRevisionGame, config: RevisionOperatorConfig[T]): BeliefRevisionGame =
  var nextAgents: seq[Agent] = @[]
  for agentId in 0..<G.agents.len:
    let 
      context = G.connection[agentId].mapIt(G.agents[it].belief)
      operator = G.revisionOperators[agentId]
    nextAgents.add(Agent(
      id: agentId,
      belief : operator(config, G.agents[agentId].belief, context)
    ))
  BeliefRevisionGame(
    agents: nextAgents,
    connection: G.connection,
    revisionOperators: G.revisionOperators
  )