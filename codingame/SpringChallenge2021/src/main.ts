/* eslint-disable require-jsdoc */
import {Cell} from './Cell';
import {Tree} from './Tree';

/**
 * Reads a line from an input
 * @return {string} the read line
 */
 declare function readline(): string;

const WAIT = 'WAIT';
const SEED = 'SEED';
const GROW = 'GROW';
const COMPLETE = 'COMPLETE';

class Action {
  type: string;
  targetCellIdx: number;
  sourceCellIdx: number;

  constructor(type: string, targetCellIdx?: number, sourceCellIdx?: number) {
    this.type = type;
    this.targetCellIdx = targetCellIdx;
    this.sourceCellIdx = sourceCellIdx;
  }

  static parse(line: string) {
    const parts = line.split(' ');
    if (parts[0] === WAIT) {
      return new Action(WAIT);
    }
    if (parts[1] === SEED) {
      return new Action(SEED, parseInt(parts[2]), parseInt(parts[1]));
    }
    return new Action(parts[0], parseInt(parts[1]));
  }
  toString() {
    if (this.type === WAIT) {
      return WAIT;
    }
    if (this.type === SEED) {
      return `${SEED} ${this.sourceCellIdx} ${this.targetCellIdx}`;
    }
    return `${this.type} ${this.targetCellIdx}`;
  }
}

class Game {
  day: number;
  round: number;
  nutrients: number;
  cells: Cell[];
  possibleActions: Action[];
  trees: Tree[];
  mySun: number;
  myScore: number;
  opponentSun: number;
  opponentScore: number;
  opponentIsWaiting: boolean;

  constructor() {
    this.day = 0;
    this.round = 0;
    this.nutrients = 0;
    this.cells = [];
    this.possibleActions = [];
    this.trees = [];
    this.mySun = 0;
    this.myScore = 0;
    this.opponentSun = 0;
    this.opponentScore = 0;
    this.opponentIsWaiting = false;
  }

  getNextAction() {
    // TODO: write your algorithm here
    return this.possibleActions[0];
  }
}

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
