// titleize
const titleize = (names, callback) => {
  const alteredNames = names.map(name => `Mx. ${ name } Jingleheimer Schmidt`)
  callback(alteredNames);
};

const printCallback = names => {
  names.forEach(name => console.log(name));
};

// titleize(["Mary", "Brian", "Leo"], printCallback);

// constructor functions

function Elephant(name, height, tricks) {
  this.name = name;
  this.height = height;
  this.tricks = tricks;
};

Elephant.prototype.trumpet = function () {
  console.log(this.name + " goes 'phrRRRRRRRRRRR!!!!!!!'");
};

Elephant.prototype.grow = function() {
  this.height++;
};

Elephant.prototype.addTrick = function(trick) {
  this.tricks.push(trick);
};

Elephant.prototype.play = function() {
  const idx = Math.floor(Math.random() * (this.tricks.length - 1))
  console.log(idx);
  console.log(`${ this.name } is ${ this.tricks[idx] }!`);
}

// let e = new Elephant('YOyo', 6, []);
// e.trumpet();
// e.addTrick('painting');
// e.addTrick('flowering');
// e.addTrick('balancing');
// e.addTrick('showering');
// e.play();

// let ellie = new Elephant("Ellie", 185, ["giving human friends a ride", "playing hide and seek"]);
// let charlie = new Elephant("Charlie", 200, ["painting pictures", "spraying water for a slip and slide"]);
// let kate = new Elephant("Kate", 234, ["writing letters", "stealing peanuts"]);
// let micah = new Elephant("Micah", 143, ["trotting", "playing tic tac toe", "doing elephant ballet"]);

// let herd = [ellie, charlie, kate, micah];

// Elephant.paradeHelper = function(elephant) {
//   console.log(`${ elephant.name } is trotting by!`);
// }

// herd.forEach(ele => Elephant.paradeHelper(ele)

// closures

// const dinerBreakfast = () => {
//   let order = "I'd like cheesy scrambled eggs please."
//   console.log(order);
  
//   return food => {
//     order = `${ order.slice(0, order.length - 8) } and ${ food } please.`;
//     console.log(order);
//   };
// };


const dinerBreakfast = () => {
  let order = ['cheesy scrambled eggs'];
  const printOrder = () => {
    console.log(`I'd like ${ order.join(" and ")} please.`)
  };
  printOrder();

  return food => {
    order.push(food);
    printOrder();
  };
};

let bfastOrder = dinerBreakfast();
bfastOrder("chocolate chip pancakes");
bfastOrder("grits");