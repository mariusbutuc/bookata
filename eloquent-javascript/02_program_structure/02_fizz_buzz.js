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
 */

const fizz = "Fizz";
const buzz = "Buzz";

for (let counter = 1; counter <= 100; counter++) {
  if (counter % 3 === 0 && counter % 5 === 0) {
    console.log(fizz + buzz);
  } else if (counter % 3 === 0) {
    console.log(fizz);
  } else if (counter % 5 === 0) {
    console.log(buzz);
  } else {
    console.log(counter)
  }
}
