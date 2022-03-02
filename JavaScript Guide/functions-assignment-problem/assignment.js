/* eslint-disable */

function sayHello(name) {
  console.log("Hi " + name);
}

const sayHelloArrow = (name) => console.log("Hi " + name);

const saySomething = (phrase, name) => console.log(phrase, name);
const sayHowzit = () => console.log("Howzit?");
const getHelloPhrase = (name) => `Hello, ${name}`;

const sayDefault = (name = "user") => console.log("Hello ", name);

const checkInput = (callback, ...strings) => {
  for (s of strings) {
    if (!s) {
      return;
    }
  }
  result = strings.join(" ");
  callback(result);
};

sayHello("First");

sayHelloArrow("Arrow");

saySomething("What's up", "John");
sayHowzit();
console.log(getHelloPhrase("James"));

sayDefault();

checkInput((result) => console.log(result), "hello", "John", "James", "et al.");

checkInput((result) => console.log(result), "hello", "", "James", "et al.");
