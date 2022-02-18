// Old way

const Student = function StudentConstructor(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.courses = [];
};

Student.prototype.name = function fullName() {
  return `${this.firstName} ${this.lastName}`;
};

Student.prototype.enroll = function enrollInCourse(newCourse) {
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
};

Student.prototype.courseLoad = function creditsPerDepartment() {
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
};

const Course = function CourseConstructor(
  courseName,
  department,
  credits,
  daysOfWeek,
  timeslot
) {
  this.courseName = courseName;
  this.department = department;
  this.credits = credits;
  this.daysOfWeek = daysOfWeek;
  this.timeslot = timeslot;

  this.students = [];
};

Course.prototype.addStudent = function enrollStudent(student) {
  try {
    student.enroll(this);
  } catch (error) {
    console.error(`Couldn't enroll -- ${error}`);
  }
  this.students.push(student);
};

Course.prototype.conflictsWith = function conflictsWithCourse(course) {
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
};

// const s1 = new Student("Stefan", "Vosloo");
// const s2 = new Student("Danielle", "Vosloo");

// const course1 = new Course("Biology", "Natural Science", 12, ["mon", "wed"], 1);
// const course2 = new Course(
//   "Chemistry",
//   "Natural Science",
//   12,
//   ["mon", "tue"],
//   1
// );
// const course3 = new Course(
//   "English Literature",
//   "Humanities",
//   10,
//   ["tue", "fri"],
//   1
// );
// // const course4 = new Course("Philosophy", "Humanities", 16);
// // const course5 = new Course("Mathematical Statistics", "Mathematics", 12);

// console.log(s1.name());
// console.log(s2.name());

// course1.addStudent(s1);
// course2.addStudent(s1);
// course3.addStudent(s1);
// // course5.addStudent(s1);

// course3.addStudent(s2);
// // course4.addStudent(s2);
// // course5.addStudent(s2);

// console.log(s1.courses.length);
// console.log(s2.courses.length);
// console.log(course1.students.length);
// // console.log(course5.students.length);

// console.log(s1.courseLoad());
// console.log(s2.courseLoad());

// console.log(course2.conflictsWith(course3));
