import types
import sequtils
import propositionalLogic

proc interact*(G: BeliefRevisionGame, allInterpretations: seq[Interpretation]): BeliefRevisionGame =
  var nextAgents: seq[Agent] = @[]
  for agentId in 0..<G.agents.len:
    let 
      context = G.connection[agentId].mapIt(G.agents[it].belief)
      operator = G.revisionOperators[agentId]
    nextAgents.add(Agent(
      id: agentId,
      belief : operator(G.agents[agentId].belief, context, allInterpretations, G.atomicFormulae)
    ))
  BeliefRevisionGame(
    agents: nextAgents,
    connection: G.connection,
    atomicFormulae: G.atomicFormulae,
    revisionOperators: G.revisionOperators
  )