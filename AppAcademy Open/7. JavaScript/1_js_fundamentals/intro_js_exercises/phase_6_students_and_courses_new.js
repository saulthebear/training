/* eslint-disable max-classes-per-file */
class Student {
  constructor(firstName, lastName) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.courses = [];
  }

  name() {
    return `${this.firstName} ${this.lastName}`;
  }

  enroll(newCourse) {
    if (this.courses.includes(newCourse)) {
      return;
    }

    const conflicts = this.courses.some((enrolledCourse) =>
      enrolledCourse.conflictsWith(newCourse)
    );

    if (conflicts) {
      throw new Error("Timeslot conflicts!");
    }

    this.courses.push(newCourse);
  }

  courseLoad() {
    const courseLoadMap = new Map();

    this.courses.forEach((course) => {
      if (courseLoadMap.has(course.department)) {
        const newVal = courseLoadMap.get(course.department) + course.credits;
        courseLoadMap.set(course.department, newVal);
      } else {
        courseLoadMap.set(course.department, course.credits);
      }
    });

    return courseLoadMap;
  }
}

class Course {
  constructor(courseName, department, credits, daysOfWeek, timeslot) {
    this.courseName = courseName;
    this.department = department;
    this.credits = credits;
    this.daysOfWeek = daysOfWeek;
    this.timeslot = timeslot;

    this.students = [];
  }

  addStudent(student) {
    try {
      student.enroll(this);
    } catch (error) {
      console.log(`Couldn't enroll -- ${error}`);
    }
    this.students.push(student);
  }

  conflictsWith(course) {
    if (course.timeslot !== this.timeslot) {
      return false;
    }

    for (let i = 0; i < this.daysOfWeek.length; i += 1) {
      const day = this.daysOfWeek[i];
      if (course.daysOfWeek.includes(day)) {
        return true;
      }
    }

    return false;
  }
}

const s1 = new Student("Stefan", "Vosloo");
const s2 = new Student("Danielle", "Vosloo");

console.log(s1);
console.log(s1.name());

const course1 = new Course("Biology", "Natural Science", 12, ["mon", "wed"], 1);
const course2 = new Course(
  "Chemistry",
  "Natural Science",
  12,
  ["mon", "tue"],
  1
);
const course3 = new Course(
  "English Literature",
  "Humanities",
  10,
  ["tue", "fri"],
  1
);
