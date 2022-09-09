/*
Design a stack which, in addition to push and pop, has a function min which
returns the minimum element. Push, pop and min should all operate in O(1) time.
*/

class MinStack {
  #arr: number[] = [];
  #min: number = Infinity;
  #minCount = 0;
  opsCount = 0;
  minCalcs = 0;
  minCounts = 0;

  push(val: number): void {
    this.opsCount++;
    this.#arr.push(val);

    if (val < this.#min) {
      this.#min = val;
      this.#minCount = this.countMin();
    }
  }

  pop(): number | null {
    this.opsCount++;
    const val = this.#arr.pop();
    if (!val) return null;

    if (val === this.#min) {
      this.#minCount--;
      if (this.#minCount === 0) {
        this.#min = this.findMin();
        this.#minCount = this.countMin();
      }
    }

    return val;
  }

  min(): number | null {
    if (this.#minCount === 0) return null;

    const min = this.#min;
    this.#minCount -= 1;

    if (this.#minCount === 0) {
      this.#min = this.findMin();
      this.#minCount = this.countMin();
    }

    return min;
  }

  private findMin(): number {
    this.minCalcs++;
    return this.#arr.reduce((min, el) => {
      if (el < min) return el;
      return min;
    });
  }

  private countMin(): number {
    this.minCounts++;
    return this.#arr.reduce((sum, el) => {
      if (el === this.#min) {
        return sum + 1;
      }
      return sum;
    }, 0);
  }
}

const s = new MinStack();
