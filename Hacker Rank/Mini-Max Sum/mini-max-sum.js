'use strict';

process.stdin.resume();
process.stdin.setEncoding('utf-8');

let inputString = '';
let currentLine = 0;

process.stdin.on('data', inputStdin => {
    inputString += inputStdin;
});

process.stdin.on('end', _ => {
    inputString = inputString.replace(/\s*$/, '')
        .split('\n')
        .map(str => str.replace(/\s*$/, ''));

    main();
});

function readLine() {
    return inputString[currentLine++];
}

// Complete the miniMaxSum function below.
function miniMaxSum(arr) {
    arr.sort();
    let min = arr.slice(0, arr.length - 1).reduce((a,b) => a+b, 0);
    let max = arr.slice(1, arr.length).reduce((a,b) => a+b, 0);
    console.log(min + ' ' + max);
}

function main() {
    const arr = readLine().split(' ').map(arrTemp => parseInt(arrTemp, 10));

    miniMaxSum(arr);
}
