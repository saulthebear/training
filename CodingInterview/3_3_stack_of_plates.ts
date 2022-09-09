/*
Implement SetOfStacks. SetOfStacks should be composed of several stacks and
should create a new stack once the previous one exceeds capacity.
SetOfStacks.push() SetOfStacks.pop() should behave identically to a single stack
*/

class StackNode<T> {
  public next: StackNode<T> | null = null;

  constructor(public val: T) {}
}

class ShortStack<T> {
  private length: number = 0;
  private head: StackNode<T> | null = null;

  constructor(private readonly limit: number) {}

  get isFull(): boolean {
    return this.length === this.limit;
  }

  get isEmpty(): boolean {
    return this.length === 0;
  }

  push(val: T) {
    if (this.isFull) throw new Error('Stack already full');

    this.length += 1;

    const newNode = new StackNode(val);
    newNode.next = this.head;
    this.head = newNode;
  }

  pop(): T {
    if (this.isEmpty || !this.head) throw new Error('Stack is empty');

    const val = this.head.val;
    this.length -= 1;
    this.head = this.head.next;

    return val;
  }

  toString() {
    let s = '';
    let curr = this.head;
    while (curr) {
      s += `<${curr.val}>->`;
      curr = curr.next;
    }
    s += 'X';
    return s;
  }
}

class SetOfStacks<T> {
  private head: StackNode<ShortStack<T>> | null = null;

  constructor(private readonly limit: number) {
    if (limit < 1) throw new Error('Limit must be greater than zero.');
  }

  push(val: T) {
    if (!this.head) {
      const newShortStack = new ShortStack<T>(this.limit);
      newShortStack.push(val);
      this.head = new StackNode(newShortStack);
      return;
    }

    if (this.head.val.isFull) {
      // Create a new short stack
      const newShortStack = new ShortStack<T>(this.limit);
      newShortStack.push(val);
      const newSetNode = new StackNode(newShortStack);
      newSetNode.next = this.head;
      this.head = newSetNode;
      return;
    }

    this.head.val.push(val);
  }

  pop(): T | null {
    if (!this.head) return null;

    if (this.head.val.isEmpty) {
      this.head = this.head.next;
    }

    if (!this.head) return null;

    return this.head.val.pop();
  }

  toString() {
    let s = '';

    let curr = this.head;
    while (curr) {
      s += `[${curr.val}] => `;
      curr = curr.next;
    }

    s += 'X';

    return s;
  }
}
