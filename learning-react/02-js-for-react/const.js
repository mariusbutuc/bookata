/**
 * A constant, declared with `const`, is a variable that cannot be overwritten.
 */

const book = "Learning React";

const book = "Learning React, 2nd Ed";
// Uncaught SyntaxError: Identifier 'book' has already been declared

book = "Learning React, 2nd Ed";
// Uncaught TypeError: Assignment to constant variable.
