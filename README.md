# belief-revision-games
Unofficial implementation of belief revision games [1] by [Nim](https://nim-lang.org/).

## Installation
```
$ nimble install https://github.com/Azumabashi/belief-revision-games
```

This library depends on [`propositionalLogic`](https://github.com/Azumabashi/nim-propositional-logic).

## Usage
See [the main file](https://github.com/Azumabashi/belief-revision-games/blob/main/src/beliefRevisionGames.nim) or [test programs](https://github.com/Azumabashi/belief-revision-games/tree/main/tests).

The expected beliefs in the test programs are calculated by the existing simulator [2]. The simulator may work on Ubuntu (while I have not tested), but did not work in my computer (OS: macOS). How to make it work in my (and probably your) computer is described in [here](note-on-existing-simulator.md).

## License
MIT

## References
1. Schwind, N., Inoue, K., Bourgne, G., Konieczny, S., & Marquis, P. (2015). Belief Revision Games. Proceedings of the AAAI Conference on Artificial Intelligence, 29(1). https://doi.org/10.1609/aaai.v29i1.9415
2. https://www.cril.univ-artois.fr/en/software/brg/