import {Cell} from './Cell';
import {Tree} from './Tree';
import {Action, COMPLETE, WAIT, GROW} from './Action';

export class Game {
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
    // return this.possibleActions[0];
    for (let i = 0; i < this.trees.length; i++) {
      const tree = this.trees[i];
      if (tree.isMine) {
        // eslint-disable-next-line max-len
        console.error(`I have a tree at ${tree.cellIndex} of size ${tree.size}. Dormant? ${tree.isDormant}`);
        // return new Action(COMPLETE, tree.cellIndex);
        if (tree.isDormant) continue;

        // TODO: Check if enough sun points
        if (tree.size < 3) return new Action(GROW, tree.cellIndex);
        else return new Action(COMPLETE, tree.cellIndex);
        // return new Action(WAIT);
      }
    }
  }

  getNumSizeTrees() {
    const sumSizes = [0, 0, 0, 0];

    for (let i = 0; i < this.trees.length; i++) {
      const tree = this.trees[i];
      if (tree.isMine) sumSizes[tree.size] += 1;
    }

    return sumSizes;
  }
}
