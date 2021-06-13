const madLib = (verb, adj, noun) => {
  let output = 'We shall ';
  output += `${ verb.toUpperCase() } the `;
  output += `${ adj.toUpperCase() } ${ noun.toUpperCase()}.`
  console.log(output);
};

const isSubstring = (searchString, subString) => {
 for (let i = 0; i < searchString.length; i++) {
   for(let j = i + 1; j <= searchString.length; j++) {
     if (searchString.slice(i, j) === subString) return true
   };
 };

 return false;
};

const fizzBuzz = array => {
  return array.filter(num => {
    return (num % 5 === 0 || num % 3 === 0) && (num % 15 !== 0);
  });
};

const isPrime = num => {
  if (num <= 1) return false;
  if ( num === 2) return true;

  for (let i = 2; i <= num / 2; i ++) {
    if ( num % i === 0) return false
  };

  return true;
};

const sumOfPrimes = n => {
  let sum = 0;
  let count = 0;
  let currentPrime = 2;

  do {
    if (count === n) break;
    if (isPrime(currentPrime)) {
      count++;
      sum += currentPrime;
    }

    currentPrime++;
  } while (count < n);

  return sum;
};