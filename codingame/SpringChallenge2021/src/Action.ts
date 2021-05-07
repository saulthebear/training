import {Tree} from './Tree';

export const WAIT = 'WAIT';
export const SEED = 'SEED';
export const GROW = 'GROW';
export const COMPLETE = 'COMPLETE';

export class Action {
  type: string;
  targetCellIdx: number;
  sourceCellIdx: number;

  constructor(type: string, targetCellIdx?: number, sourceCellIdx?: number) {
    this.type = type;
    this.targetCellIdx = targetCellIdx;
    this.sourceCellIdx = sourceCellIdx;
  }

  static parse(line: string): Action {
    const parts = line.split(' ');
    if (parts[0] === WAIT) {
      return new Action(WAIT);
    }
    if (parts[1] === SEED) {
      return new Action(SEED, parseInt(parts[2]), parseInt(parts[1]));
    }
    return new Action(parts[0], parseInt(parts[1]));
  }

  toString(): string {
    if (this.type === WAIT) {
      return WAIT;
    }
    if (this.type === SEED) {
      return `${SEED} ${this.sourceCellIdx} ${this.targetCellIdx}`;
    }
    return `${this.type} ${this.targetCellIdx}`;
  }

  static getGrowCost(tree: Tree, treeSizes: number[]): number {
    switch (tree.size) {
      case 0: {
        return 1 + treeSizes[1];
      }
      case 1: {
        return 3 + treeSizes[2];
      }
      case 2: {
        return 7 + treeSizes[3];
      }
    }
  }

  /**
   * Get the sun cost of an action
   * @param {Action} action
   * @param {number[]} treeSizes Array of number of each size tree I own
   * @param {Tree} tree The tree to grow or complete
   * @return {number} The sun cost of the action
   */
  static getActionCost(
      action: Action | string, treeSizes?: number[], tree?: Tree): number {
    let type = action;
    if (action instanceof Action) type = action.type;
    switch (type) {
      case SEED: {
        return treeSizes[0];
      }
      case GROW: {
        return this.getGrowCost(tree, treeSizes);
      }
      case COMPLETE: {
        return 4;
      }
      case WAIT: {
        return 0;
      }
    }
  }
}
