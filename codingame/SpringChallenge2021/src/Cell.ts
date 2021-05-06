export class Cell {
  index: number;
  richness: number;
  neighbors: number[];
  constructor(index: number, richness: number, neighbors: number[]) {
    this.index = index;
    this.richness = richness;
    this.neighbors = neighbors;
  }
}
