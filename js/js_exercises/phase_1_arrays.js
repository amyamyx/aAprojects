Array.prototype.uniq = function() {
  const result = []
  this.forEach(el => {
    if (!result.includes(el)) result.push(el);
  });

  return result;
};


Array.prototype.twoSum = function() {
  const idxPairs = [];
  for (let i = 0; i < this.length; i++) {
    for (let j = i + 1; j < this.length; j++) {
      if (this[i] === -this[j]) idxPairs.push([i, j]);
    };
  };

  return idxPairs;
};

Array.prototype.transpose = function() {
  const result = []

  for (let i = 0; i < this.length; i ++) {
    for (let j = 0; j < this[i].length; j ++) {
      if (i === 0) result[j] = [];
      result[j][i] = this[i][j];
    }
  }
  return result;
};