/**
 * The Spread Operator
 */

/**
 * Combine the contents of multiple arrays.
 */
const canadian = ["Superior", "Huron", "Erie", "Ontario"];
const us = ["Michigan"];
const greatLakes = [...canadian, ...us];
// console.log(greatLakes.join(", ")); // Superior, Huron, Erie, Ontario, Michigan

/**
 * Clone an array to prevent it from beint mutated.
 */
const [last] = [...canadian].reverse();
// console.log(last);  Ontario
// console.log(canadian.join(", ")); // Superior, Huron, Erie, Ontario

/**
 * Get the remaining elements in an array.
 */
const [head, ...tail] = canadian;
// console.log(tail.join(", ")); // Huron, Erie, Ontario

/**
 * Collect function arguments as an array.
 *
 * This provides incredible flexibility because we can use the `directions` function to handle any number of stops.
 */
function directions(...args) {
  let [start, ...remaining] = args;
  let [finish, ...stops] = remaining.reverse();

  console.log(`Drive through ${args.length} towns:`);
  console.log(`\t+ start in ${start}`);
  console.log(`\t+ the destination is ${finish}`);
  console.log(`\t+ stopping ${stops.length} times in between`);
}

// directions("Etobicoke", "Oakville", "Burlington", "Guelph");
// Drive through 4 towns:
//         + start in Etobicoke
//         + the destination is Guelph
//         + stopping 2 times in between

/**
 * Can also be used for objects.
 */
const morning = {
  breakfast: "oatmeal",
  lunch: "trail mix",
};

const dinner = "himalayan lentils & rice";

const backpackingMeals = {
  ...morning,
  dinner,
};

console.log(backpackingMeals);
