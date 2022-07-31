/*

When planting flowers in a pot, it's important to make sure that whenever you water your plant any water that doesn't get absorbed by the roots drains out the bottom of the pot. Otherwise, the water will pool in the bottom of the pot and cause your plant to rot.

You recently decided to plant some flowers of your own, and decided to fill the base of the pot with gravel. You've decided to write code to verify whether water will successfully drain out of the pot.

Using a 2D array to represent your pot, individual pieces of gravel are notated with a 1 and empty spaces between gravel are notated with a 0.

Example Pot #1:

[
    [0, 1, 1, 1, 1],
    [0, 1, 0, 0, 0],
    [0, 0, 0, 1, 0],
    [1, 1, 1, 1, 0],
    [1, 0, 0, 1, 0],
]
Write a function to determine whether the water can fall from the top row to the bottom, moving through the spaces between the gravel. Taking the example pot from above, you can see the possible path, which is marked by replacing the relevant 0's with asterisks (*).

[
    [*, 1, 1, 1, 1],
    [*, 1, *, *, *],
    [*, *, *, 1, *],
    [1, 1, 1, 1, *],
    [1, 0, 0, 1, *],
]
Notice that the path includes both the top and bottom rows.

Allowed moves:

The only moves allowed are up, down, left, and right. Diagonals are not allowed.

Here are a few pots that don't drain properly, along with explanations.

[
    [1, 1, 1],
    [1, 1, 0],
    [1, 0, 0],
]
Explanation: The top row has no gaps.

[
    [1, 1, 0],
    [1, 1, 0],
    [1, 1, 1],
]
Explanation: The bottom row has no gaps.

[
    [1, 1, 0],
    [1, 1, 0],
    [1, 0, 1],
]
Explanation: Every row has gaps, but gaps in the middle and bottom rows are diagonal from one another, and water can't flow.

*/

class Node {
  constructor(row, col) {
    this.row = row;
    this.col = col;
  }

  get pos() {
    return [this.row, this.col];
  }

  eq(other) {
    return this.row === other.row && this.col === other.col;
  }

  get nextUp() {
    return new Node(this.row - 1, this.col);
  }

  get nextRight() {
    return new Node(this.row, this.col + 1);
  }

  get nextDown() {
    return new Node(this.row + 1, this.col);
  }

  get nextLeft() {
    return new Node(this.row, this.col - 1);
  }
}

const solution = (maze) => {
  // Type your solution here
  const getEmptyVisited = () => {
    const visited = [];
    for (let i = 0; i < maze.length; i++) {
      const row = [];
      for (let j = 0; j < maze[0].length; j++) {
        row.push(false);
      }
      visited.push(row);
    }
    return visited;
  };

  const maxRowIndex = maze.length - 1;
  const maxColIndex = maze[0].length - 1;

  const isNodeOutOfBounds = (node) => {
    if (node.row < 0 || node.col < 0) return true;
    if (node.row > maxRowIndex) return true;
    if (node.col > maxColIndex) return true;
    return false;
  };

  let visited;

  const canReachBottom = (from) => {
    if (isNodeOutOfBounds(from)) return false;
    if (visited[from.row][from.col]) return false;

    // Add to visited
    visited[from.row][from.col] = true;

    if (maze[from.row][from.col] === 1) return false;

    if (from.row === maxRowIndex) return true;

    return (
      canReachBottom(from.nextUp) ||
      canReachBottom(from.nextRight) ||
      canReachBottom(from.nextDown) ||
      canReachBottom(from.nextLeft)
    );
  };

  for (let i = 0; i < maze.length; i++) {
    const node = new Node(0, i);
    visited = getEmptyVisited();

    if (canReachBottom(node)) return true;
  }

  return false;
};
