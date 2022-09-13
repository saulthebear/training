/*
4.3 List of Depths
Given a binary tree, design an algorithm which creates a linked list of all the
nodes at each depth (e.g. if you have a tree with depth D, you'll have D linked
lists).
*/

// Linked List node
class MyNode<T> {
  public next: MyNode<T> | null = null;
  constructor(public val: T) {}
}

// Linked List
class LinkedList<T> {
  head: MyNode<T>;
  constructor(val: T) {
    this.head = new MyNode(val);
  }

  insert(val: T) {
    let curr = this.head;
    while (curr.next) {
      curr = curr.next;
    }
    curr.next = new MyNode(val);
  }

  toString(): string {
    let s = '';
    let curr: MyNode<T> | null = this.head;
    while (curr) {
      s += `<${curr.val}> => `;
      curr = curr.next;
    }
    s += 'X';
    return s;
  }
}

// Binary Tree Node
class TreeNode<T> {
  public left: TreeNode<T> | null = null;
  public right: TreeNode<T> | null = null;
  constructor(public val: T) {}
}

// Solution
function listLevels(root: TreeNode<any>): LinkedList<any>[] {
  const levels: LinkedList<any>[] = [];

  function addLevels(curr: TreeNode<any> | null, level = 0) {
    if (!curr) return;

    if (levels.length === level) {
      levels.push(new LinkedList(curr.val));
    } else {
      levels[level].insert(curr.val);
    }

    addLevels(curr.left, level + 1);
    addLevels(curr.right, level + 1);
  }
  addLevels(root);
  return levels;
}

// Construct a tree to test
const root = new TreeNode(1);
root.left = new TreeNode(2);
root.right = new TreeNode(3);
root.left.left = new TreeNode(4);
root.left.right = new TreeNode(6);
root.left.left.left = new TreeNode(5);
root.right.right = new TreeNode(7);

const levels = listLevels(root);

for (let i = 0; i < levels.length; i++) {
  const l = levels[i];
  console.log(`L${i}: ${l.toString()}`);
}
