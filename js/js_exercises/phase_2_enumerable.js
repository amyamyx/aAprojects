Array.prototype.myEach = function(callback) {
  for (let i = 0; i < this.length; i++) {
    callback(this[i]);
  };
};

Array.prototype.myMap = function (callback) {
  const newArray = [];

  this.myEach(el => newArray.push(callback(el)));

  return newArray;
};

Array.prototype.myReduce = function (callback, initialValue = null) {
  let initialNotGiven = !initialValue;
  let accumulator = initialValue || this[0];
  for (let i = 0; i < this.length; i++) {
    if (i === 0 && initialNotGiven) continue;
    accumulator = callback(accumulator, this[i]);
  };

  return accumulator;
};

