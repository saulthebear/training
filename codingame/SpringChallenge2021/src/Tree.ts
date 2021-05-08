import {Cell} from './Cell';
import * as Utils from './Utils';

export class Tree {
  cellIndex: number;
  size: number;
  isMine: boolean;
  isDormant: boolean;
  constructor(
      cellIndex: number, size: number, isMine: boolean, isDormant: boolean) {
    this.cellIndex = cellIndex;
    this.size = size;
    this.isMine = isMine;
    this.isDormant = isDormant;
  }

  getPlantableCells(board: Cell[]): Utils.ExtendSet<Cell> {
    // Tree size: 0 => none, 1 => neighbours, 2 => neighbours' neighbours, 3 =>
    if (this.size == 0) return new Utils.ExtendSet<Cell>();

    const dist1Neighbours: Utils.ExtendSet<Cell> = new Utils.ExtendSet();
    Cell.getNeighbors(this.cellIndex, board)
        .forEach((cell) => dist1Neighbours.add(cell));

    const plantableDist1Neighbours = dist1Neighbours
        .filter((cell: Cell) => cell.isPlantable());

    if (this.size == 1) return plantableDist1Neighbours;

    const dist2Neighbours: Utils.ExtendSet<Cell> = new Utils.ExtendSet<Cell>();
    // Neighbors's neihbors are 2 away
    for (const n of dist1Neighbours) {
      // Don't include self
      if (n.index != this.cellIndex) {
        Cell.getNeighbors(n, board)
            .forEach((cell) => dist2Neighbours.add(cell));
      }
    }

    const plantableDist2Neighbours = dist2Neighbours
        .filter((cell: Cell) => cell.isPlantable());
    if (this.size == 2) return plantableDist2Neighbours;

    const dist3Neighbours: Utils.ExtendSet<Cell> = new Utils.ExtendSet<Cell>();
    // Neighbors's neihbors are 2 away
    for (const n of dist2Neighbours) {
      // Don't include self
      if (n.index != this.cellIndex) {
        Cell.getNeighbors(n, board)
            .forEach((cell) => dist3Neighbours.add(cell));
      }
    }
    // console.error(`${this.cellIndex}'s dist3Neighbors: ${dist3Neighbours}`);

    const plantableDist3Neighbours = dist3Neighbours
        .filter((cell: Cell) => cell.isPlantable());
    if (this.size == 3) return plantableDist3Neighbours;
  }
}
