Array.prototype.bubbleSort = function () {
  let sorted = false;

  while (!sorted) {
    sorted = true;
    
    for (let i = 0; i < this.length - 1; i++) {
      let thisEl = this[i];
      let nextEl = this[i + 1];

      if (thisEl > nextEl) {
        [sorted, this[i], this[i + 1]] = [false, nextEl, thisEl];
      }
    };
  };

  return this;
};

String.prototype.substrings = function() {
  const result = [];
  for (let i = 0; i < this.length; i++) {
    for (let j = i + 1; j <= this.length; j++) {
      let subStr = this.slice(i, j);
      if (!result.includes(subStr)) result.push(subStr);
    };
  };

  return result;
}