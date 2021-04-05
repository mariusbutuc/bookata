/**
 * Creating functions
 */

// Function declarations are hoisted.
// logComplimentDeclaration();
//    » You're doing great!
function logComplimentDeclaration() {
  console.log("You're doing great!");
}

// Function expressions are not hoisted.
// logComplimentExpression();
//    » ReferenceError: Cannot access 'logComplimentExpression' before initialization
const logComplimentExpression = function () {
  console.log("You're doing great!");
};

/**
 * Arrow functions
 */

// Returning objects: wrap the returned object in parentheses. Otherwise:
//    » SyntaxError: Unexpected token ':'
// These missing parentheses are the source of countless bugs in JavaScript and React apps!
const person = (firstName, lastName) => ({
  first: firstName,
  last: lastName,
});
// console.log(person("Marius", "Atlist"));
//    » { first: 'Marius', last: 'Atlist' }

// Arrow functions and scope
const tahoe = {
  mountains: ["Freel", "Rose", "Tallac", "Rubicon", "Silver"],
  print: function (delay = 1000) {
    setTimeout(function () {
      console.log(this.mountains.join(", "));
    }, delay);
  },
};
// tahoe.print();
// TypeError: Cannot read property 'join' of undefined

// Use the arrow function syntax to protect the scope of `this`.
const protectedTahoe = {
  mountains: ["Freel", "Rose", "Tallac", "Rubicon", "Silver"],
  print: function (delay = 1000) {
    setTimeout(() => {
      console.log(this.mountains.join(", "));
    }, delay);
  },
};
// protectedTahoe.print();
//    » Freel, Rose, Tallac, Rubicon, Silver

// Arrow functions do not block off the scope of `this`.
const altTahoe = {
  mountains: ["Freel", "Rose", "Tallac", "Rubicon", "Silver"],
  print: (delay = 1000) => {
    setTimeout(() => {
      console.log(this.mountains.join(", "));
    }, delay);
  },
};
// altTahoe.print();
//    » TypeError: Cannot read property 'join' of undefined
