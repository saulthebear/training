/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

const N = parseInt(readline());
for (let i = 0; i < N; i++) {
  const line = readline();

  // Stores top cargo of each stack
  const stacks = [];

  // Loop through all incoming trucks
  for (let truckNum = 0; truckNum < line.length; truckNum++) {
    // Has cargo been placed on a stack?
    let stacked = false;
    const currentCargo = line.charAt(truckNum);

    // Find a the first stack with a top cargo less than current cargo
    // and place current cargo on top
    for (let stackNum = 0; stackNum < stacks.length; stackNum++) {
      if (stacks[stackNum] >= currentCargo) {
        stacks[stackNum] = currentCargo;
        stacked = true;
        break;
      }
    }

    // If cargo can't be placed on existing stacks, create a new stack
    if (!stacked) stacks.push(currentCargo);
  }
  console.log(stacks.length);
}
