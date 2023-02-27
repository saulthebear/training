class TreeNode<T> {
  private leftNode: TreeNode<T> | null = null;
  private rightNode: TreeNode<T> | null = null;
  parent: TreeNode<T> | null = null;
  constructor(public val: T) {}

  set left(n: TreeNode<T> | null) {
    if (!n) {
      this.leftNode = null;
      return;
    }

    if (n.val > this.val) {
      throw new Error('Left values must be less than or equal');
    }

    this.leftNode = n;
    n.parent = this;
  }

  set right(n: TreeNode<T> | null) {
    if (!n) {
      this.rightNode = null;
      return;
    }

    if (n.val <= this.val) {
      throw new Error('Right vals must be greater');
    }

    this.rightNode = n;
    n.parent = this;
  }

  get left() {
    return this.leftNode;
  }

  get right() {
    return this.rightNode;
  }
}

function treeMin(root: TreeNode<number>): TreeNode<number> {
  if (!root.left) return root;

  return treeMin(root.left);
}

function next(node: TreeNode<number>): TreeNode<number> | null {
  if (!node) return null;

  if (!node.right) {
    if (!node.parent) return null;

    if (node.parent.val >= node.val) return node.parent;

    // Keep going up and to the left
    let ancestor: TreeNode<number> | null = node.parent;
    while (ancestor && ancestor.val < node.val) {
      ancestor = ancestor.parent;
    }
    return ancestor;
  }

  return treeMin(node.right);
}

const n8 = new TreeNode(8);
const n3 = new TreeNode(3);
const n10 = new TreeNode(10);
const n1 = new TreeNode(1);
const n6 = new TreeNode(6);
const n14 = new TreeNode(14);
const n4 = new TreeNode(4);
const n7 = new TreeNode(7);
const n13 = new TreeNode(13);

n8.left = n3;
n8.right = n10;

n3.left = n1;
n3.right = n6;

n10.right = n14;

n6.left = n4;
n6.right = n7;

n14.left = n13;

const result = next(n7);
console.log(result ? `<${result.val}>` : 'X');
