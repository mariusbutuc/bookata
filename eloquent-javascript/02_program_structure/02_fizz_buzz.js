/**
 * FizzBuzz
 *
 * Write a program that uses `console.log` to print all the numbers
 * from 1 to 100, with two exceptions:
 *    1. for numbers divisible by 3, print "Fizz" instead of the number, and
 *    2. for numbers divisible by 5 (and not 3), print "Buzz" instead.
 *
 * When you have that working, modify your program to print "FizzBuzz" for
 * numbers that are divisible by both 3 and 5 (and still print "Fizz" or "Buzz"
 * for numbers divisible by only one of those).
 *
 * For the "clever" solution, build up a string containing the word or words to
 * output and print either this word or the number if there is no word,
 * potentially by making good use of the || operator.
 */

const fizz = "Fizz";
const buzz = "Buzz";

for (let counter = 1; counter <= 100; counter++) {
  let words = "";

  if (counter % 3 === 0 && counter % 5 === 0) {
    words = words + fizz + buzz;
  } else if (counter % 3 === 0) {
    words = words + fizz;
  } else if (counter % 5 === 0) {
    words = words + buzz;
  }

  console.log(words || counter);
}
