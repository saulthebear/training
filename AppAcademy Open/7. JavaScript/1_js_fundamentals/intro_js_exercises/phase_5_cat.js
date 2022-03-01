const Cat = function CatConstructor(name, owner) {
  this.name = name;
  this.owner = owner;
};

Cat.prototype.cuteStatement = function makeCuteStatement() {
  return `${this.owner} loves ${this.name}`;
};

const bodhi = new Cat("Bodhi", "Stefan");
const soy = new Cat("Soy Boy", "Chloe");

console.log(bodhi.cuteStatement());
console.log(soy.cuteStatement());

Cat.prototype.cuteStatement = function makeCuteStatement2() {
  return `Everyone loves ${this.name}!`;
};

console.log(bodhi.cuteStatement());
console.log(soy.cuteStatement());

Cat.prototype.meow = function quietMeow() {
  return "Meow!";
};

console.log(bodhi.meow());
console.log(soy.meow());

bodhi.meow = function loudMewo() {
  return "MEOooW!";
};

console.log(bodhi.meow());
console.log(soy.meow());
