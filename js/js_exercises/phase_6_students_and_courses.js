class Student {
  constructor(fname, lname) {
    this._fname = fname;
    this._lname = lname;
    this._courses = [];
  }

  get fname() {
    return this._fname;
  }

  get lname() {
    return this._lname;
  }

  get courses() {
    return this._courses;
  }

  name() {
    return `${ this._fname } ${ this._lname }`;
  }

  enroll(course) {

    if (this.noConflicts(course)) {
      this._courses.push(course);
      course.addStudent(this);
    };
  }

  courseLoad() {
    let credits = {};
    this._courses.forEach(course => {
      if (!credits.hasOwnProperty(course.dept)) credits[course.dept] = 0;
      credits[course.dept] += course.credits;
    });

    return credits;
  }

  noConflicts(course) {
    let noConflict = true
    let conflictMessage = `You can't enroll ${ course.name }. Conflicted courses:`;
    this._courses.forEach(myCourse => {
      if (myCourse.conflictsWith(course)) {
        conflictMessage += `\n${ myCourse.name }`;
        noConflict = false;
      }
    })
    if (!noConflict) alert(conflictMessage);
    return noConflict;
  }

};

class Course {
  constructor(name, dept, credits, days, block) {
    this._name = name;
    this._dept = dept;
    this._credits = credits;
    this._students = [];
    this._days = days;
    this._block = block;
  }

  get name() {
    return this._name;
  }

  get dept() {
    return this._dept;
  }

  get credits() {
    return this._credits;
  }

  get students() {
    return this._students;
  }

  get days() {
    return this._days;
  }

  get block() {
    return this._block;
  }

  addStudent(student) {
    this._students.push(student);
  }

  conflictsWith(course) {
    if (course.block !== this._block) return false;
    if (isOverlap(course.days, this._days)) return true;
    return false;
  }
}

const isOverlap = (arr1, arr2) => {
  let overlap = false;
  arr1.forEach(el => {
    if (arr2.includes(el)) overlap =  true
  });
  return overlap;
}

let mary = new Student("Mary", "Lou");
let math = new Course("Math", "Mathemetics", 3, ["mon", "tue", "wed"], 1);
let eng = new Course("English", "Literature", 2, ["thu", "fri"], 1);
let che = new Course("Chemistry", "Science", 3, ["mon", "wed", "thu"], 3);
let phy = new Course("Physics", "Science", 3, ["tue", "wed", "fri"], 1);

mary.enroll(math);
mary.enroll(eng);
mary.enroll(phy);