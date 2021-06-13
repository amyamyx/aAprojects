const range = (start, end) => {
  if (start > end) return [];
  if (start === end) return [start];
  
  return [start].concat(range(start + 1, end));
};

const sumRec = (numArr) => {
  if (numArr.length === 0) return 0;
  return numArr[0] + sumRec(numArr.slice(1));
};

const exp1 = (base, power) => {
  if (power === 0) return 1;
  return base * exp1(base, power - 1);
};

const exp2 = (base, power) => {
  if (power === 0) return 1;
  if (power === 1) return base;
  if (power % 2 === 0) return exp2(base, power / 2) ** 2;
  return base * (exp2(base, (power - 1) / 2) ** 2);
};

const fibonacci = n => {
  if (n <= 2) return [0, 1].slice(0, n)
  let lastFib = fibonacci(n - 1);
  let newEl = sumRec(lastFib.slice(lastFib.length - 2));
  return lastFib.concat([newEl]);
};

const deepDup = arr => {
  if (arr.length === 0) return arr;

  let dup = [];
  
  arr.forEach(el => {
    let addingEl = Array.isArray(el) ? deepDup(el) : el;
    dup.push(addingEl);
  });

  return dup;
};

const bsearch = (arr, target) => {
  if (arr.length === 0) return -1;
  let midIdx = Math.floor(arr.length / 2);
  let mid = arr[midIdx];
  let result;

  if (mid === target) return midIdx;
  if (mid > target) return bsearch(arr.slice(0, midIdx), target);
  if (mid < target) {
    result = bsearch(arr.slice(midIdx + 1), target);
    return result >= 0 ? result + midIdx + 1 : result;
  };
};

const mergeSort = arr => {
  if (arr.length <= 1) return arr;
  let midIdx = Math.floor(arr.length / 2);
  let leftArr = mergeSort(arr.slice(0, midIdx));
  let rightArr = mergeSort(arr.slice(midIdx));

  return mergeHelper(leftArr, rightArr);
};

const mergeHelper = (arr1, arr2) => {
  let merged = [];

  while (arr1.length > 0 && arr2.length > 0) {
    if (arr1[0] > arr2[0]) {
      merged.push(arr2.shift());
    } else {
      merged.push(arr1.shift());
    };
  };

  return merged.concat(arr1).concat(arr2);
};

const subsets = arr => {
  if (arr.length === 0) return [[]];

  let prev = subsets(arr.slice(0, arr.length - 1));
  let lastEl = arr[arr.length - 1];
  let addingEl = prev.map(el => el.concat([lastEl]));

  return prev.concat(addingEl);
};