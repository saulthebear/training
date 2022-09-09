/*
Design a stack which, in addition to push and pop, has a function min which
returns the minimum element. Push, pop and min should all operate in O(1) time.
*/

//////////////////////
// APPROACH 1       //
// O(n) time       //
// O(1) space      //
////////////////////

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

//////////////////////
// APPROACH 2       //
// O(1) time        //
// O(n) extra space //
//////////////////////

class MinNode {
  next: MinNode | null = null;

  constructor(public val: number, public min: number) {}
}

class MinStack2 {
  private head: MinNode | null = null;

  push(val: number) {
    if (!this.head) {
      this.head = new MinNode(val, val);
      return;
    }

    const new_min = Math.min(this.head.min, val);
    const new_node = new MinNode(val, new_min);
    new_node.next = this.head;
    this.head = new_node;
  }

  pop(): number | null {
    if (!this.head) return null;

    const val = this.head.val;

    this.head = this.head.next;

    return val;
  }

  min(): number | null {
    if (!this.head) return null;

    return this.head.min;
  }

  toString(): string {
    let s = '';
    let curr = this.head;
    while (curr) {
      s += `<${curr.val} | ${curr.min}> => `;

      curr = curr.next;
    }

    s += 'X';

    return s;
  }
}

////////////////////////////////////////////////
// APPROACH 3                                 //
// O(1) time                                  //
// O(n) extra space                           //
// But on average, less space than approach 2 //
////////////////////////////////////////////////

class Node2 {
  public next: Node2 | null = null;
  constructor(public val: number) {}
}

class MinStack3 {
  private minHead: Node2 | null = null;
  private stackHead: Node2 | null = null;

  push(val: number) {
    if (!this.stackHead) {
      this.stackHead = new Node2(val);
      this.minHead = new Node2(val);
      return;
    }

    if (val < this.min()!) {
      const newMin = new Node2(val);
      newMin.next = this.minHead;
      this.minHead = newMin;
    }

    const newNode = new Node2(val);
    newNode.next = this.stackHead;
    this.stackHead = newNode;
  }

  pop(): number | null {
    if (!this.stackHead || !this.minHead) return null;

    const val = this.stackHead.val;

    if (val === this.min()) {
      this.minHead = this.minHead.next;
    }

    this.stackHead = this.stackHead.next;
    return val;
  }

  min(): number | null {
    if (!this.minHead) return null;

    return this.minHead.val;
  }

  toString() {
    let minS = '';
    let stackS = '';

    let curr = this.minHead;
    while (curr) {
      minS += `<${curr.val}> => `;
      curr = curr.next;
    }
    curr = this.stackHead;
    while (curr) {
      stackS += `<${curr.val}> => `;
      curr = curr.next;
    }
    minS += 'X';
    stackS += 'X';
    return `${stackS} || ${minS}`;
  }
}
