/* eslint-disable require-jsdoc */
import {Cell} from './Cell';
import {Tree} from './Tree';
import {Action} from './Action';
import {Game} from './Game';

/**
 * Reads a line from an input
 * @return {string} the read line
 */
 declare function readline(): string;

const game = new Game();

const numberOfCells = parseInt(readline());
for (let i = 0; i < numberOfCells; i++) {
  const inputs = readline().split(' ');
  const index = parseInt(inputs[0]);
  const richness = parseInt(inputs[1]);
  const neigh0 = parseInt(inputs[2]);
  const neigh1 = parseInt(inputs[3]);
  const neigh2 = parseInt(inputs[4]);
  const neigh3 = parseInt(inputs[5]);
  const neigh4 = parseInt(inputs[6]);
  const neigh5 = parseInt(inputs[7]);
  game.cells.push(
      new Cell(index, richness,
          [neigh0, neigh1, neigh2, neigh3, neigh4, neigh5]),
  );
}


// eslint-disable-next-line no-constant-condition
while (true) {
  game.day = parseInt(readline());
  game.nutrients = parseInt(readline());
  let inputs = readline().split(' ');
  game.mySun = parseInt(inputs[0]);
  game.myScore = parseInt(inputs[1]);
  inputs = readline().split(' ');
  game.opponentSun = parseInt(inputs[0]);
  game.opponentScore = parseInt(inputs[1]);
  game.opponentIsWaiting = inputs[2] !== '0';
  game.trees = [];
  const numberOfTrees = parseInt(readline());
  for (let i = 0; i < numberOfTrees; i++) {
    const inputs = readline().split(' ');
    const cellIndex = parseInt(inputs[0]);
    const size = parseInt(inputs[1]);
    const isMine = inputs[2] !== '0';
    const isDormant = inputs[3] !== '0';
    game.trees.push(
        new Tree(cellIndex, size, isMine, isDormant),
    );
  }
  game.possibleActions = [];
  const numberOfPossibleAction = parseInt(readline());
  for (let i = 0; i < numberOfPossibleAction; i++) {
    const possibleAction = readline();
    game.possibleActions.push(Action.parse(possibleAction));
  }

  const action = game.getNextAction();
  console.log(action.toString());
}
