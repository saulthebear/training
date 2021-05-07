import {Cell} from './Cell';
import {Tree} from './Tree';
import {Action, COMPLETE} from './Action';

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
        return new Action(COMPLETE, tree.cellIndex);
      }
    }
  }
}
