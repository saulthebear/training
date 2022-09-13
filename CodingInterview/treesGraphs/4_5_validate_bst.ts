class TreeNode<T> {
  left: TreeNode<T> | null = null;
  right: TreeNode<T> | null = null;
  constructor(public val: T) {}
}

function validate(node: TreeNode<any> | null) {
  if (!node) return true;

  if (node.left && node.left.val >= node.val) return false;
  if (node.right && node.right.val < node.val) return false;
  if (!validate(node.left)) return false;
  if (!validate(node.right)) return false;

  return true;
}

const n1 = new TreeNode(1);
const n2 = new TreeNode(2);
const n3 = new TreeNode(3);
const n4 = new TreeNode(4);
const n5 = new TreeNode(5);
const n6 = new TreeNode(6);
const n7 = new TreeNode(7);
const n8 = new TreeNode(8);
const n9 = new TreeNode(9);
const n10 = new TreeNode(10);
const n11 = new TreeNode(10);
const n12 = new TreeNode(12);
const n13 = new TreeNode(13);
const n14 = new TreeNode(14);

// n1.left = n7;
// n1.right = n9;
// n7.left = n2;
// n7.right = n6;
// n9.right = n10;
// n6.left = n5;
// n6.right = n11;

// console.log(validate(n1))

n8.left = n3;
n8.right = n10;
n3.left = n1;
n3.right = n6;
n10.right = n14;
n6.left = n4;
n6.right = n7;
n14.left = n13;

console.log(validate(n8));
