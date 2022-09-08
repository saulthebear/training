/*
  Use a single array to implement three stacks
*/
class TriStack<T> {
  s2Start = 1;
  s2End = 1;
  arr: (T | null)[] = [null, null, null];
  stack1: Stack<T>;
  stack2: Stack<T>;
  stack3: Stack<T>;

  constructor() {
    this.stack1 = new StackOne(this);
    this.stack2 = new StackTwo(this);
    this.stack3 = new StackThree(this);
  }

  shiftLeft(start: number) {
    const removed_val = this.arr[start];

    for (let i = start; i < this.arr.length - 1; i++) {
      this.arr[i] = this.arr[i + 1];
    }

    this.arr.pop();
    return removed_val;
  }

  shiftRight(start: number, val: T) {
    this.arr.push(this.arr[this.arr.length - 1]);

    for (let i = this.arr.length - 1; i > start; i--) {
      this.arr[i] = this.arr[i - 1];
    }

    this.arr[start] = val;
  }

  toString() {
    return `
      One (${this.stack1.start} -> ${
      this.stack1.end
    }): ${this.stack1.toString()}
      Two (${this.stack2.start} -> ${
      this.stack2.end
    }): ${this.stack2.toString()}
      Three (${this.stack3.start} -> ${
      this.stack3.end
    }): ${this.stack3.toString()}`;
  }
}

abstract class Stack<T> {
  protected triStack: TriStack<T>;
  protected length = 0;

  constructor(triStack: TriStack<T>) {
    this.triStack = triStack;
  }

  get isEmpty() {
    return this.length === 0;
  }

  abstract get start(): number;

  abstract get end(): number;

  abstract add(val: T): void;

  abstract remove(): T | null;

  toString() {
    if (this.length === 0) return '[]';

    let s = '[';
    const lastIndex = this.start + this.length - 1;
    for (let i = this.start; i <= lastIndex; i++) {
      if (i === lastIndex) {
        s += this.triStack.arr[i];
      } else {
        s += `${this.triStack.arr[i]}, `;
      }
    }
    return s + ']';
  }
}

class EmptyStackError extends Error {}

class StackOne<T> extends Stack<T> {
  constructor(triStack: TriStack<T>) {
    super(triStack);
  }

  get start() {
    return 0;
  }

  get end() {
    return this.triStack.s2Start - 1;
  }

  add(val: T) {
    this.length += 1;

    if (this.length === 1) {
      this.triStack.arr[this.start] = val;
      return;
    }

    this.triStack.shiftRight(this.start, val);
    this.triStack.s2Start++;
    this.triStack.s2End++;
  }

  remove() {
    if (this.isEmpty) throw new EmptyStackError();

    this.length -= 1;

    if (this.length === 0) {
      return this.triStack.arr[this.start];
    }

    const val = this.triStack.shiftLeft(this.start);
    this.triStack.s2Start--;
    this.triStack.s2End--;
    return val;
  }
}

class StackTwo<T> extends Stack<T> {
  constructor(triStack: TriStack<T>) {
    super(triStack);
  }

  get start() {
    return this.triStack.s2Start;
  }

  get end() {
    return this.triStack.s2End;
  }

  add(val: T) {
    this.length += 1;

    if (this.length === 1) {
      this.triStack.arr[this.start] = val;
      return;
    }

    this.triStack.shiftRight(this.start, val);
    this.triStack.s2End++;
  }

  remove() {
    if (this.isEmpty) throw new EmptyStackError();

    this.length -= 1;

    if (this.length === 0) {
      return this.triStack.arr[this.start];
    }

    const val = this.triStack.shiftLeft(this.start);
    this.triStack.s2End--;
    return val;
  }
}

class StackThree<T> extends Stack<T> {
  constructor(triStack: TriStack<T>) {
    super(triStack);
  }

  get start() {
    return this.triStack.s2End + 1;
  }

  get end() {
    return this.triStack.arr.length - 1;
  }

  add(val: T) {
    this.length += 1;

    if (this.length === 1) {
      this.triStack.arr[this.start] = val;
      return;
    }
    this.triStack.arr.push(val);
  }

  remove() {
    if (this.isEmpty) throw new EmptyStackError();

    this.length -= 1;

    if (this.length === 0) {
      return this.triStack.arr[this.start];
    }

    return this.triStack.arr.pop()!;
  }
}
