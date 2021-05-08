import {Cell} from './Cell';
import {Tree} from './Tree';
import {Action, COMPLETE, WAIT, GROW, SEED} from './Action';

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

  getNextAction(): Action {
    // TODO: write your algorithm here
    // return this.possibleActions[0];

    // Sort trees by cell richness before completing
    // this.trees.sort((a, b) => {
    //   const cellARichness = Cell.getCell(a.cellIndex, this.cells).richness;
    //   const cellBRichness = Cell.getCell(b.cellIndex, this.cells).richness;

    //   return cellBRichness - cellARichness;
    // });

    // GROW
    for (let i = 0; i < this.trees.length; i++) {
      const tree = this.trees[i];
      if (tree.isMine && !tree.isDormant) {
        const growAction = this.tryGrow(tree);
        if (growAction) {
          console.error(`Returning GROW Action`);
          return growAction;
        }
      }
    }

    // COMPLETE
    for (let i = 0; i < this.trees.length; i++) {
      const tree = this.trees[i];
      if (tree.isMine && !tree.isDormant) {
        const completeAction = this.tryCompleteTree(tree);
        if (completeAction) {
          console.error(`Returning COMPLETE Action`);
          return completeAction;
        }
      }
    }

    // SEED
    for (let i = 0; i < this.trees.length; i++) {
      const tree = this.trees[i];
      if (tree.isMine && !tree.isDormant) {
        if (tree.size > 0) {
          console.error(`Trying to seed from tree at ${tree.cellIndex}`);
          // const plantableCells = tree.getPlantableCells(this.cells);
          // console.error(`Plantable cells outside: ${plantableCells}`);
          const seedAction = this.trySeed(tree);
          if (seedAction) {
            console.error('Returning SEED Action');
            return seedAction;
          }
        }
      }
    }

    // for (let i = 0; i < this.trees.length; i++) {
    //   const tree = this.trees[i];

    //   if (tree.isMine && !tree.isDormant) {
    //     const growAction = this.tryGrow(tree);
    //     if (growAction) {
    //       console.error(`Returning GROW Action`);
    //       return growAction;
    //     }

    //     const completeAction = this.tryCompleteTree(tree);
    //     if (completeAction) {
    //       console.error(`Returning COMPLETE Action`);
    //       return completeAction;
    //     }

    //     if (tree.size > 0) {
    //       console.error(`Trying to seed from tree at ${tree.cellIndex}`);
    //       // const plantableCells = tree.getPlantableCells(this.cells);
    //       // console.error(`Plantable cells outside: ${plantableCells}`);
    //       const seedAction = this.trySeed(tree);
    //       if (seedAction) {
    //         console.error('Returning SEED Action');
    //         return seedAction;
    //       }
    //     }
    //   }
    // }
    console.error(`Returning WAIT Action`);
    return new Action(WAIT);
  }

  tryCompleteTree(tree: Tree): Action {
    console.error(`Trying to complete ${tree.cellIndex}`);
    const completeAction = new Action(COMPLETE, tree.cellIndex);
    const isAffordable = this.mySun >= Action.getActionCost(completeAction);
    if (tree.size > 2 && !tree.isDormant && isAffordable) {
      const cell = Cell.getCell(tree.cellIndex, this.cells);
      cell.isFree = true;
      return completeAction;
    }
    let reason = 'Unknown reason!!';
    if (!isAffordable) reason = 'Not enough sun';
    if (tree.size < 3) reason = 'Tree too small';
    if (tree.isDormant) reason = 'Tree is dormant';
    console.error(`Unable to complete ${tree.cellIndex}: ${reason}`);
    return null;
  }

  tryGrow(tree: Tree): Action | null {
    console.error(`Trying to grow ${tree.cellIndex}`);
    const growAction = new Action(GROW, tree.cellIndex);
    const cost = Action.getActionCost(growAction, this.getNumSizeTrees(), tree);
    const isAffordable = this.mySun >= cost;
    if (tree.size < 3 && !tree.isDormant && isAffordable) {
      return growAction;
    }
    let reason = 'Unknown reason!!';
    if (!isAffordable) reason = 'Not enough sun';
    if (tree.size == 3) reason = 'Tree already size 3';
    if (tree.isDormant) reason = 'Tree is dormant';
    console.error(`Unable to grow ${tree.cellIndex}: ${reason}`);
    return null;
  }

  // trySeedNeighbour(parent: Tree): Action | null {
  //   const isAffordable = this.mySun >
  //     Action.getActionCost(SEED, this.getNumSizeTrees(), parent);
  //   if (!isAffordable) return;

  //   const parentCell: Cell = Cell.getCell(parent.cellIndex, this.cells);

  //   // console.error(`Neighbours: ${parentCell.neighbors}`);

  //   for (const neighbour of parentCell.neighbors) {
  //     if (neighbour == -1) continue; // Out of bounds
  //     const neighbourCell = Cell.getCell(neighbour, this.cells);
  //     if (!neighbourCell.isFree) continue; // Occupied
  //     if (neighbourCell.richness == 0) continue; // Richness too low
  //     console.error(`Seeding ${neighbour} from ${parent.cellIndex}`);
  //     neighbourCell.isFree = false;
  //     return new Action(SEED, neighbour, parent.cellIndex);
  //   }
  //   return null;
  // }

  trySeed(parent: Tree): Action | null {
    const isAffordable = this.mySun >
      Action.getActionCost(SEED, this.getNumSizeTrees(), parent);
    if (!isAffordable) {
      console.error('Unable to seed: Not enough sun.');
      return null;
    }

    const plantableCells: Cell[] = Array.from(
        parent.getPlantableCells(this.cells));
    // console.error(`Plantable cells: ${plantableCells}`);
    if (plantableCells.length == 0) {
      console.error('Unable to seed: No plantable cells.');
      return null;
    }

    plantableCells.sort((cell1, cell2) => {
      const richDiff = cell2.richness - cell1.richness;
      if (richDiff == 0) return cell1.index - cell2.index;
      return richDiff;
    });

    console.error(`Plantable cells (sorted): ${plantableCells}`);

    const chosenCell = plantableCells[0];
    console.error(`trySeed(${parent.cellIndex}) => ${chosenCell.index}`);
    chosenCell.isFree = false;
    return new Action(SEED, chosenCell.index, parent.cellIndex);
  }

  /**
   * Get the number of my tree of each size
   * @return {number[]} Sum of my trees of each size. Index 0 => size 0, etc.
   */
  getNumSizeTrees(): number[] {
    const sumSizes = [0, 0, 0, 0];

    for (let i = 0; i < this.trees.length; i++) {
      const tree = this.trees[i];
      if (tree.isMine) sumSizes[tree.size] += 1;
    }

    return sumSizes;
  }
}
