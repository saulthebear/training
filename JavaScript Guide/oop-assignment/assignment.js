/*
  Create a "Course" class which has three properties: "title", "length" and
  "price" (all set up in the constructor). Instantiate the class twice (two
  dummy courses of your choice). Output the objects to the console
*/

class Course {
  constructor(title, lengthInHours, price) {
    this.title = title;
    this.length = lengthInHours;
    this.price = price;
  }
}

const course1 = new Course("JS Complete Guide", 10, 11);
const course2 = new Course("React", 5, 50);

console.log(course1);
console.log(course2);
