const WAIT = 'WAIT';
const SEED = 'SEED';
const GROW = 'GROW';
const COMPLETE = 'COMPLETE';

export class Action {
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
