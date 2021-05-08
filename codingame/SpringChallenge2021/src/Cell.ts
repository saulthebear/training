export class Cell {
  index: number;
  richness: number;
  neighbors: number[];
  isFree: boolean = true;
  constructor(index: number, richness: number, neighbors: number[]) {
    this.index = index;
    this.richness = richness;
    this.neighbors = neighbors;
  }

  isPlantable(): boolean {
    return (this.richness > 0 && this.isFree);
  }

  public toString(): string {
    return `Cell ${this.index}`;
  }

  static getCell(index: number, board: Cell[]): Cell {
    for (let i = 0; i < board.length; i++) {
      if (board[i].index == index) return board[i];
    }
  }

  static getNeighbors(cell: Cell | number, board: Cell[]): Cell[] {
    // If cell is index (number) convert it to a Cell
    if (!(cell instanceof Cell)) cell = Cell.getCell(cell, board);

    return cell.neighbors
        .filter((idx) => idx != -1)
        .map((idx): Cell => Cell.getCell(idx, board));
  }
}
