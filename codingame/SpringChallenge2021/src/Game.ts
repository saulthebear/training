/* eslint-disable require-jsdoc */
import {Tree} from './Tree';
import {Cell} from './Cell';

export class Game {
  private _cells: Cell[] = [];
  private _trees: Tree[] = [];

  public get cells(): Cell[] {
    return this._cells;
  }
  public set cells(value: Cell[]) {
    this._cells = value;
  }

  public get trees(): Tree[] {
    return this._trees;
  }
  public set trees(value: Tree[]) {
    this._trees = value;
  }

  function completeTrees(trees: Tree[]) {
    console.error(`There are ${trees.length} trees to process`);
    let completed = false;
    for (let i = 0; i < trees.length; i++) {
      const tree = trees[i];
      if (tree.isMine) {
        console.log(COMPLETE + ' ' + tree.cellIndex);
        completed = true;
      }
    }
    if (!completed) console.log(WAIT);
  }

}
