// https://www.codingame.com/ide/puzzle/1d-spreadsheet

const N = parseInt(readline());
const unresolved = [];
/**
 * @type {cell: number, value: number}
 */
const resolved = {};
for (let i = 0; i < N; i++) {
  const inputs = readline().split(' ');
  // const operation = inputs[0];
  // const arg1 = inputs[1];
  // const arg2 = inputs[2];
  unresolved.push(inputs);
}

for (let i = 0; i < N; i++) {
  // Write an answer using console.log()
  // To debug: console.error('Debug messages...');
  const value = resolve(i);
  // console.error(`Cell: ${i}, Value: ${value}`);
  console.log(value);
}

/**
 * Perform an operation and return the result
 * @param {string} operation - Operation to perform (VALUE, ADD, SUB, MULT)
 * @param {string|number} arg1 - Number or reference to a cell (eg. '$1')
 * @param {string|number} arg2 - Number or reference to a cell (eg. '$1')
 * @return {number|null} - result of the operation or null if invalid
 */
function doOperation(operation, arg1, arg2) {
  // console.error(`Doing Operation: [${operation}, ${arg1}, ${arg2}]`)
  if ((isString(arg1) && arg1.includes('$')) ||
      (isString(arg2) && arg2.includes('$'))) return null;

  let result;

  switch (operation) {
    case 'VALUE':
      result = arg1;
      break;
    case 'ADD':
      result = parseInt(arg1) + parseInt(arg2);
      break;
    case 'SUB':
      result = parseInt(arg1) - parseInt(arg2);
      break;
    case 'MULT':
      result = parseInt(arg1) * parseInt(arg2);
      break;
    default:
      result = null;
  }

  if (result === -0) result = 0;
  return result;
}

/**
 * Recursively resolves the value of a cell.
 * @param {number|string} cell - The cell number or
 * cell reference string (eg. '$0')
 * @return {number} - the value of the cell
 */
function resolve(cell) {
  // console.error('Attempting to resolve ' + cell);
  if (isString(cell)) {
    cell = parseCellRef(cell);
  }

  if (resolved.hasOwnProperty(cell)) return resolved[cell];

  // console.error(`unresolved[${cell}]: ${unresolved[cell]}`);

  const operation = unresolved[cell][0];
  let arg1 = unresolved[cell][1];
  let arg2 = unresolved[cell][2];

  // console.error(`Operation: ${operation}, arg1: ${arg1}, arg2: ${arg2}`);

  if (!arg1.includes('$') && !arg2.includes('$')) {
    return doOperation(operation, arg1, arg2);
  }

  if (arg1.includes('$')) {
    arg1 = resolve(arg1);
  }

  if (arg2.includes('$')) {
    arg2 = resolve(arg2);
  }

  // Add cell to resolved cache
  const value = doOperation(operation, arg1, arg2);
  resolved[cell] = value;

  return value;
}

/**
 * Converts cellRef string to number
 * @param {string} cellRef - Cell reference string eg. '$1'
 * @return {number}
 */
function parseCellRef(cellRef) {
  return cellRef.substr(1);
}

function isString(val) {
  return typeof val === 'string' || val instanceof String;
}
