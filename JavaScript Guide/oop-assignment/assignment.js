/* eslint-disable max-classes-per-file */

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

/*
  Use getters and setters to ensure that the "price" property can only be set to
  a positive value and is returned with a "$" in front of it.
*/

class Course {
  get price() {
    return `$${this._price.toFixed(2)}`;
  }

  set price(newPrice) {
    if (newPrice < 0) {
      this._price = 0;
    } else {
      this._price = newPrice;
    }
  }

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
    const priceString = `Price: ${this.price}`;
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

/*
  Create two new, more specialized, classes: "PracticalCourse" and
  "TheoreticalCourse". Both should be based on the "Course" class but
  "PracticalCourse" should also have a "numOfExercises" property,
  "TheoreticalCourse" should have a "publish()" method (which just prints
  something to the console). Instantiate both and use the new AND old properties
  and methods.
*/

class PracticalCourse extends Course {
  constructor(title, lengthInHours, price, numberOfExercises) {
    super(title, lengthInHours, price);
    this.numberOfExercises = numberOfExercises;
  }
}

class TheoreticalCourse extends Course {
  publish() {
    console.log(`Publishing "${this.title}"`);
  }
}

const course1 = new Course("JS Complete Guide", 10, 11);
const course2 = new Course("React", 5, 50);
const course3 = new PracticalCourse("50 JS Projects", 20, 20, 50);
const course4 = new TheoreticalCourse("Linear Algebra Theory", 100, 20);

console.log(course1);
console.log(course1.getSummary());

console.log(course2);
console.log(course2.getSummary());

console.log(course3);
console.log(course3.getSummary());
console.log("Exercise count:", course3.numberOfExercises);

console.log(course4);
console.log(course4.getSummary());
console.log(course4.publish());
