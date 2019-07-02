/**
 * ## Arrow functions
 *
 *  * `this` is lexically bound
 *  * syntax rules:
 *      * 1 arg => no parens
 *      * multiple args => use parens
 *      * 1 LoC => implicit return + no need for curly braces
 *      * multiple LoC => curly braces required
 *      * returning an object requires parens around return statement
 */
const numbers = [0, 1, 2];

// Before arrow functions:
// numbers.forEach(function(number) {
//     return console.log(number);
// });

// Refactor to use arrow functions:
// numbers.forEach(number => console.log(number));
// » 0
// » 1
// » 2



// `this` is lexically bound
const unboundQuotient = {
    numbers: [1, 2, 3, 4, 5, 6, 7],
    results: [],
    divideFn: function(divisor) {
        return this.numbers.map(function(divident) {
            if (divident % divisor === 0) {
                return this.results.push(divident);
                // TypeError: Cannot read property 'push' of undefined
            }
        })
    }
}

const quotient = {
    numbers: [1, 2, 3, 4, 5, 6, 7],
    results: [],
    divideFn: function(divisor) {
        return this.numbers.map(divident => {
            if (divident % divisor === 0) {
                return this.results.push(divident);
            }
        })
    }
}

quotient.divideFn(3);
// console.log(quotient.results);
// » [ 3, 6 ]



// Example: multiple args + returning an object
const greet = (name, age) => ({
    name,
    age
})

console.log(
    greet('Steve', 18)
);
// » { name: 'Steve', age: 18 }
