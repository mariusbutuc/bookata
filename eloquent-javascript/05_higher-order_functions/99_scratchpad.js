for (let i = 0; i < 10; i++) {
  // console.log(i);
}

function repeatLog(n) {
  for (let i = 0; i < n; i++) {
    console.log(i);
  }
}
// repeatLog(10);

function repeat(n, action) {
  for (let i = 0; i < n; i++) {
    action(i);
  }
}
// repeat(3, console.log);

let labels = [];
repeat(5, unitNumber => {
  labels.push(`Unit ${unitNumber + 1}`);
});
// console.log(labels);

function greaterThan(n) {
  return m => m > n;
}
let greaterThan10 = greaterThan(10);
// console.log(greaterThan10(11));

function noisy(fun) {
  return (...args) => {
    console.log("calling with", args);
    let result = fun(...args);
    console.log("called with ", args, ", returned", result);
    return result;
  };
}
// noisy(Math.min)(3, 2, 1);

function unless(test, then) {
  if (!test) then();
}

repeat(3, n => {
  unless(n % 2 == 1, () => {
    // console.log(n, "is even");
  });
});

// ["A", "B"].forEach(letter => console.log(letter));

// *** Script data set ***
const SCRIPTS = require("./scripts");

// {
//   name: "Coptic",
//   ranges: [[994, 1008], [11392, 11508], [11513, 11520]],
//   direction: "ltr",
//   year: -200,
//   living: false,
//   link: "https://en.wikipedia.org/wiki/Coptic_alphabet"
// }

// # Filterig arrays
function filter(array, test) {
  let passed = [];
  for (let element of array) {
    if (test(element)) {
      passed.push(element);
    }
  }
  return passed;
}

// console.dir(filter(SCRIPTS, script => script.living));
// console.log(SCRIPTS.filter(script => script.direction == "ttb"));

// # Transforming with map
function map(array, transform) {
  let mapped = [];
  for (let element of array) {
    mapped.push(transform(element));
  }
  return mapped;
}
let rtlScripts = filter(SCRIPTS, script => script.direction == "rtl");
// console.log(map(rtlScripts, script => script.name));

// # Summarizing with reduce
function reduce(array, combine, start) {
  let current = start;
  for (let element of array) {
    current = combine(current, element);
  }
  return current;
}
// console.log(reduce([1, 2, 3, 4], (a, b) => a + b, 0));
// console.log([1, 2, 3, 4].reduce((a, b) => a + b));

// {
//   name: "Coptic",
//   ranges: [[994, 1008], [11392, 11508], [11513, 11520]],
//   direction: "ltr",
//   year: -200,
//   living: false,
//   link: "https://en.wikipedia.org/wiki/Coptic_alphabet"
// }

function characterCount(script) {
  return script.ranges.reduce((count, [from, to]) => {
    return count + (to - from);
  }, 0);
}
let largestCharacterCount = SCRIPTS.reduce((a, b) => {
  return characterCount(a) < characterCount(b) ? b : a;
});
// console.log(largestCharacterCount);

// # Composability
// Find the biggest script without using higher-order functions
let biggest = null;
for (let script of SCRIPTS) {
  if (biggest == null || characterCount(biggest) < characterCount(script)) {
    biggest = script;
  }
}
// console.log(biggest);

// # Strings and Caharacter Codes
function characterScript(code) {
  for (let script of SCRIPTS) {
    let codeBelongsToScript = script.ranges.some(([from, to]) => {
      return code >= from && code < to;
    });

    if (codeBelongsToScript) {
      return script;
    }
  }
  return null;
}
// console.log(characterScript(121));

let horseShoe = "🐴👟";
// console.log(horseShoe.length);
// console.log(horseShoe[0]);
// console.log(horseShoe.charCodeAt(0));
// console.log(horseShoe.codePointAt(0));

let roseDragon = "🌹🐉";
for (let char of roseDragon) {
  // console.log(char);
}

// # Recognizing text
function countBy(items, groupName) {
  let counts = [];
  for (let item of items) {
    let name = groupName(item);
    let known = counts.findIndex(c => c.name == name);
    if (known == -1) {
      counts.push({ name, count: 1 });
    } else {
      counts[known].count++;
    }
  }
  return counts;
}
// console.log(countBy([1, 2, 3, 4, 5], n => n > 2));

function textScripts(text) {
  let scripts = countBy(text, char => {
    let script = characterScript(char.codePointAt(0));
    return script ? script.name : "none";
  }).filter(({ name }) => name != "none");

  let total = scripts.reduce((n, { count }) => n + count, 0);
  if (total == 0) return "No scripts found";

  return scripts
    .map(({ name, count }) => {
      return `${Math.round((count * 100) / total)}% ${name}`;
    })
    .join(", ");
}
// console.log(textScripts('英国的狗说"woof", 俄罗斯的狗说"тяв"'));
