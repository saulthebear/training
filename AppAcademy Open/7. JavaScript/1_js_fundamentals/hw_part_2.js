// Phase I
/**
 *
 * @param {string[]} names
 * @param {function} callback
 */
function titleize(names, callback) {
  const titledNames = names.map((name) => `Mx. ${name} Jingleheimer Schmidt`);
  callback(titledNames);
}

/**
 * @param {string[]} strings
 */
function printAll(strings) {
  strings.forEach((string) => console.log(string));
}

// titleize(['Mary', 'Brian', 'Leo'], printAll);

// Phase II

/**
 * @param {string} name
 * @param {number} height - In inches
 * @param {string[]} tricks - In gerund form
 */
function Elephant(name, height, tricks) {
  this.name = name;
  this.height = height;
  this.tricks = tricks;
}

Elephant.prototype.trumpet = function trumpet() {
  console.log(`${this.name} the elephant goes 'phrRRRRR!!!!!`);
};

Elephant.prototype.grow = function grow() {
  this.height += 1;
};

Elephant.prototype.addTrick = function addTrick(trick) {
  this.tricks.push(trick);
};

Elephant.prototype.play = function printRandomTrick() {
  const numberOfTricks = this.tricks.length;
  const randomIndex = Math.floor(Math.random() * numberOfTricks);
  const randomTrick = this.tricks[randomIndex];
  const trickString = `${this.name} is ${randomTrick}`;

  console.log(trickString);
};

const ellie = new Elephant("Ellie", 185, [
  "giving human friends a ride",
  "playing hide and seek",
]);
const charlie = new Elephant("Charlie", 200, [
  "painting pictures",
  "spraying water for a slip and slide",
]);
const kate = new Elephant("Kate", 234, ["writing letters", "stealing peanuts"]);
const micah = new Elephant("Micah", 143, [
  "trotting",
  "playing tic tac toe",
  "doing elephant ballet",
]);

const herd = [ellie, charlie, kate, micah];

Elephant.paradeHelper = function printElephantTrot(elephant) {
  console.log(`🐘 ${elephant.name} is trotting by! 🐘`);
};

herd.forEach(Elephant.paradeHelper);

function dinerBreakfast() {
  const orderItems = [""];
  return function (item) {
    orderItems.push(item);

    const fullOrder = orderItems.reduce(
      (acc, orderItem) => `${acc} and ${orderItem}`
    );

    const politeFullOrder = `I'd like ${fullOrder} please`;

    console.log(politeFullOrder);
  };
}

const breakfastOrder = dinerBreakfast();
breakfastOrder("cheesy scrambled eggs");
breakfastOrder("chocolate chip pancakes");
breakfastOrder("grits");
