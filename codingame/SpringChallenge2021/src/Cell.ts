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

  static getCell(index: number, cells: Cell[]): Cell {
    for (let i = 0; i < cells.length; i++) {
      if (cells[i].index == index) return cells[i];
    }
  }
}
