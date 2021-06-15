// window.setTimeout(() => {
//   alert('HAMMERTIME')
// }, 5000);

// const hammerTime = time => {
//   window.setTimeout(() => {
//     alert(`${ time } is hammertime!`)
//   }, 5000);
// };

const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const ask = (cb) => {
  reader.question('Would you like some tea?\n', (res1) => {
    console.log(`you replied ${ res1 }.`)

    reader.question('Would you like some biscuits?\n', res2 => {
      console.log(`you replied ${ res2 }.`)

      cb(res1, res2)
    });
  });
};

ask((...args) => {
  args = args.map(res => res === 'yes' ? 'do' : 'don\'t' );
  
  console.log(`So you ${ args[0]} want tea and you ${ args[1]} want biscuits.`);
  reader.close();
})