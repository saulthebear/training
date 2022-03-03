/*
  Create a "Course" class which has three properties: "title", "length" and
  "price" (all set up in the constructor). Instantiate the class twice (two
  dummy courses of your choice). Output the objects to the console
*/

/*
  Add two methods to the "Course" class: A method which calculates the 
  length/price value ("how much length do you get for the amount paid") and one
  method that outputs a nice course summary (including title, length and price).
  Call these methods thereafter (and output the result to the console).
*/

class Course {
  constructor(title, lengthInHours, price) {
    this.title = title;
    this.length = lengthInHours;
    this.price = price;
  }

  getValue() {
    return (this.length / this.price) * 60;
  }

  getSummary() {
    const titleString = `Title: ${this.title}`;
    const lengthString = `Length: ${this.length} hours`;
    const priceString = `Price: $${this.price.toFixed(2)}`;
    const valueString = `Value: ${this.getValue().toFixed(0)} minutes/$`;

    return `
    == COURSE SUMMARY ==
    ${titleString}
    ${lengthString}
    ${priceString}
    ${valueString}
    `;
  }
}

const course1 = new Course("JS Complete Guide", 10, 11);
const course2 = new Course("React", 5, 50);

console.log(course1);
console.log(course1.getSummary());

console.log(course2);
console.log(course2.getSummary());
