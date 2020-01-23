/*******************************************************************************
 * Methods
 *  properties that hold values
 */
let rabbit = {};
rabbit.speak = function(line) {
  console.log(`The rabbit says '${line}'`);
};
// rabbit.speak("I'm alive!");
// » The rabbit says 'I'm alive!'

/**
 * The binding called `this`…
 * in a method's body automatically points to the object that it was called on.
 */
function speak(line) {
  console.log(`The ${this.type} rabbit says '${line}'`);
}
let whiteRabbit = { type: "white", speak };
let hungryRabbit = { type: "hungry", speak };
// whiteRabbit.speak("Oh my ears and whiskers, " + "how late it's getting!");
// » The white rabbit says 'Oh my ears and whiskers, how late it's getting!'
// hungryRabbit.speak("I could use a carrot right now!");
// » The hungry rabbit says 'I could use a carrot right now!'

// speak.call(hungryRabbit, "Burp!");
// » The hungry rabbit says 'Burp!'

/**
 * Arrow functions don't bind their own `this`.
 * They can see the `this` binding of the scope around them.
 */
function normalize() {
  console.log(this.coords.map(n => n / this.length));

  // console.log(this.coords.map( (n) =>
  //   console.log('foo')
  //   n / this.length
  // ));

  // console.log(this.coords.map(function(n) {
  //   console.log(Object.keys(this));
  //   return n / this.length;
  // }));
}
// normalize.call({coords: [0, 2, 3], length: 5});
// » [ 0, 0.4, 0.6 ]

// foo = {coords: [0, 2, 3], length: 5, normalize};
// foo.normalize;
// foo.normalize();

/*******************************************************************************
 * Prototypes
 *
 * In addition to their properties, *most objects* also have a _prototype_.
 * A prototype is another object that is used as a fallback source of properties.
 */
let empty = {};
// console.log(empty.toString);
// » [Function: toString]
// console.log(empty.toString());
// » [object Object]

/**
 * The great ancestral prototype, the entity behind *almost* all objects,
 * `Object.prototype`.
 */
// console.log(Object.getPrototypeOf({}));
// » {}
// console.log(Object.getPrototypeOf({}) == Object.prototype);
// » true
// console.log(Object.getPrototypeOf(Object.prototype));
// » null

/**
 * TODO: How do I find, explore, introspect the few methods that show up in all
 * objects, such as `toString`?
 */
// console.log(Object.keys(Object.prototype))
// » []

/**
 * Other objects as prototypes, other than `Object.prototype`
 */
// console.log(Object.getPrototypeOf(Math.max))
// » [Function]
// console.log(Object.getPrototypeOf(Math.max) == Function.prototype)
// » true
// console.log(Object.getPrototypeOf([]) == Array.prototype);
// » true

/**
 * `Object.create` creates an object with a specific prototype.
 *
 * The "proto" rabbit acts as a container for the properties that are shared by
 * all rabbits. The individual rabbit object *derives* these shared properties
 * from its prototype.
 */
let protoRabbit = {
  speak(line) {
    console.log(`The ${this.type} rabbit says '${line}'`);
  }
};
// let killerRabbit = Object.create(protoRabbit);
// killerRabbit.type = "killer";
// killerRabbit.speak("SKREEE!!");
// » The killer rabbit says 'SKREEE!!'
// » The undefined rabbit says 'SKREEE!!'

/*******************************************************************************
 * Classes
 *
 * A class defines *the shape of a type of object* — what methods and properties
 * it has. Such an object is called an _instance_ of the class.
 * Prototype/class/template/struct/shape + default values
 */

/**
 * To create an instance of a class, we need a _constructor_.
 * It
 *    1. Makes an object that derives from the proper prototype.
 *    2. Ensures that this instance has the properties of that instances of this
 *       class are supposed to have.
 *
 * To instantiate/constructtype:
 *  1. create object from prototype object
 *  2. set instance specific properties
 *  3. return object
 */
function makeRabbit(type) {
  let rabbit = Object.create(protoRabbit);
  rabbit.type = type;
  return rabbit;
}

let nextKillerRabbit = makeRabbit("next killer");
// nextKillerRabbit.speak("MOAR SKREEE!!");
// » The next killer rabbit says 'MOAR SKREEE!!'

/**
 * Create as function » arguments = instance specific properties
 *  Set properties on prototype
 *  Use `new`
 *
 * Constructor names are capitalized (class names)
 */

/*******************************************************************************
 * Class notation
 *
 * JS classes
 *  1. constructor functions
 *  2. with a `prototype` property
 */

/**
 * ES6
 *  1. Class keyword
 *  2. define a constructor
 *  3. define a set of methods
 *    + the `constructor` one is treated specially
 *    + currently, only methods (properties that hold functions)
 */
class Rabbit {
  constructor(type) {
    this.type = type;
  }
  speak(line) {
    console.log(`The ${this.type} rabbit says '${line}'`);
  }
}

let killerRabbit = new Rabbit("killer");
let blackRabbit = new Rabbit("black");

/*******************************************************************************
 * Overriding Derived Properties
 */
Rabbit.prototype.teeth = "small";
// console.log(killerRabbit.teeth);
killerRabbit.teeth = "long, sharp, and bloody";
//  » small
// console.log(killerRabbit.teeth);
//  » long, sharp, and bloody
// console.log(blackRabbit.teeth);
//  » small
// console.log(Rabbit.prototype.teeth);
//  » small

/*******************************************************************************
 * Maps
 */

/**
 * Implementing Maps with objects » dangerous!
 */
// let ages = {
//   Boris: 39,
//   Liang: 22,
//   Júlia: 62
// };
// console.log(`Júlia is ${ages["Júlia"]}`);
//  » Júlia is 62
// console.log("Is Jack's age known?", "Jack" in ages);
//  » Is Jack's age known? false
// console.log("Is toString's age known?", "toString" in ages);
//  » Is toString's age known? true

/**
 * Creating objects with no prototype is possible
 */
// console.log("toString" in Object.create(null));
//  » false

/**
 * JavaScript's `Map` class / data structure
 *  1. stores a mapping
 *  2. allows for any type of keys
 *  3. interface contains `set`, `get`, and `has`
 *  4. can quickly update and search a large set of values
 */
let ages = new Map();
ages.set("Boris", 39);
ages.set("Liang", 22);
ages.set("Júlia", 62);
// console.log(`Júlia is ${ages.get("Júlia")}`);
//  » Júlia is 62
// console.log("Is Jack's age known?", ages.has("Jack"));
//  » Is Jack's age known? false
// console.log("Is toString's age known?", ages.has("toString"));
//  » Is toString's age known? false

/**
 * Object.keys() » returns only an object's own keys. Not those in the prototype
 * The hasOwnProperty() ignores the object's prototype
 */
// console.log({x: 1}.hasOwnProperty("x"));
//  » true
// console.log({x: 1}.hasOwnProperty("toString"));
//  » false

/*******************************************************************************
 * Polymorphism
 *
 * When a piece of code is written to work with objects that have a certain
 * interface, any kind of object that happens to support this interface can be
 * plugged into the code, and it will just work.
 */
// console.log(String(blackRabbit));
//  » [object Object]
Rabbit.prototype.toString = function() {
  return `a ${this.type} rabbit`;
};
// console.log(String(blackRabbit));
//  » a black rabbit

/*******************************************************************************
 * Symbols
 *
 *  * created with the `Symbol` function
 *  * compared to strings, symbols are unique
 *  * the string passed in is just a "string representation of the symbol's name"
 *  * multiple symbols can have the same name.
 */

let sym = Symbol("name");
// console.log(sym == Symbol("name"));
//  » false
Rabbit.prototype[sym] = 55;
// console.log((blackRabbit[sym]));
//  » 55
// console.log((blackRabbit.sym));
//  » undefined

const toStringSymbol = Symbol("toString");
Array.prototype[toStringSymbol] = function() {
  return `${this.length} cm of blue yarn`;
};

let arrayToStringify = [1, 2];
// console.log(arrayToStringify.toString());
//  » 1,2
// console.log(arrayToStringify[toStringSymbol]());
//  » 2 cm of blue yarn

/**
 * The property name that is a symbol can be defined in either object
 * expressions and/or classes by using the square bracket notation, as this
 * causes the property name to be evaluated.
 */
let stringObject = {
  [toStringSymbol]() {
    return "a jute (iută) rope";
  }
};
// console.log(stringObject[toStringSymbol]());
//  » a jute (iută) rope

/*******************************************************************************
 * The iterator interface
 *
 *  * is the actual thing that iterates
 *  * it has a `next` method that returns the next result
 *  * the next result should be an object with
 *    * a `value` property, that provides the next value, if there is one.
 *    * a `done` property which should return
 *      * `true` when there are no more results and
 *      * `false` otherwise.
 *
 *  * the `next`, `value`, and `done` property names are plain strings, not
 *    symbols.
 *  * only Symbol.iterator, which is likely to be added to a _lot_ of different
 *    objects, is an actual symbol.
 */
// console.log(Symbol.iterator);
//  » Symbol(Symbol.iterator)
// console.log(Symbol("Marius"));
//  » Symbol(Marius)

let okIterator = "OK"[Symbol.iterator]();
// console.log(okIterator.next());
//  » { value: 'O', done: false }
// console.log(okIterator.next());
//  » { value: 'K', done: false }
// console.log(okIterator.next());
//  » { value: undefined, done: true }

/**
 * A `Matrix` class
 *
 * Implemented as an iterable data structure and acting as a two-dimensional
 * array.
 */
class Matrix {
  constructor(width, height, element = (x, y) => undefined) {
    this.width = width;
    this.height = height;
    this.content = [];

    for (let y = 0; y < height; y++) {
      for (let x = 0; x < width; x++) {
        this.content[y * width + x] = element(x, y);
      }
    }
  }

  get(x, y) {
    return this.content[y * this.width + x];
  }

  set(x, y, value) {
    this.content[y + this.width + x] = value;
  }
}

// let quickMatrix = new Matrix(2, 3, (x, y) => `(${x}, ${y})`);
let quickMatrix = new Matrix(2, 3);
// zero-based indices
// console.log(quickMatrix.get(2, 3));
// console.log(quickMatrix);
//  » undefined
// console.log(quickMatrix.get(1, 2));
//  » foo[1, 2]

// let notIterableMatrix = new Matrix(2, 3, (x, y) => `value ${x}, ${y}`);
// for (let { x, y, value } of notIterableMatrix) {
//   console.log(x, y, value);
// }
//  » TypeError: notIterableMatrix is not iterable

class MatrixIterator {
  constructor(matrix) {
    this.x = 0;
    this.y = 0;
    this.matrix = matrix;
  }

  next() {
    // zero-based index (this.y) vs. one-based index (this.matrix.height)
    //  => overflow === nothing left to iterate on
    if (this.y == this.matrix.height) return { done: true };

    let value = {
      x: this.x,
      y: this.y,
      value: this.matrix.get(this.x, this.y)
    };
    // console.log("initial value: ", value);
    this.x++;
    // zero-based index (this.x) vs. one-based index (this.matrix.width)
    //  => overflow === past column width, push to the beginning of the next row
    if (this.x == this.matrix.width) {
      this.x = 0;
      this.y++;
    }
    // console.log("value right before return statement: ", value);
    return { value, done: false };
  }
}

Matrix.prototype[Symbol.iterator] = function() {
  return new MatrixIterator(this);
};

// let foo = new Matrix(3, 4);
// let bar = new MatrixIterator(foo);

let matrix = new Matrix(2, 3, (x, y) => `value ${x}, ${y}`);
for (let { x, y, value } of matrix) {
  // console.log(x, y, value);
}

/*******************************************************************************
 * Getters, Setters, and Statics
 *
 * Inside a class declaration, methods that have `static` written before their
 * name are stored on the constructor.
 */

let varyingSize = {
  get size() {
    return Math.floor(Math.random() * 100);
  }
};

// console.log(varyingSize.size);
// console.log(varyingSize.size);

class Temperature {
  constructor(celsius) {
    this.celsius = celsius;
  }
  get fahrenheit() {
    return this.celsius * 1.8 + 32;
  }
  set fahrenheit(value) {
    this.celsius = (value - 32) / 1.8;
  }

  static fromFahrenheit(value) {
    return new Temperature((value - 32) / 1.8);
  }
}

let temp = new Temperature(22);
// console.log(temp.fahrenheit);
//  » 71.6
temp.fahrenheit = 86;
// console.log(temp.celsius);
//  » 30
temp.celsius = 32;
// console.log(temp.celsius);
//  » 32

let boilingTemp = Temperature.fromFahrenheit(212);
// console.log('Water starts boiling at', boilingTemp.celsius, '°C');

/*******************************************************************************
 * Inheritance
 */
class SymmetricMatrix extends Matrix {
  constructor(size, element = (x, y) => undefined) {
    super(size, size, (x, y) => {
      if (x < y) return element(y, x);
      else return element(x, y);
    });
  }

  set(x, y, value) {
    super.set(x, y, value);
    if (x != y) {
      super.set(y, x, value);
    }
  }
}

let symMatrix = new SymmetricMatrix(5, (x, y) => `${x}, ${y}`);
// console.log(symMatrix.get(2, 3));
//  » 3, 2

/**
 * Fundamental parts of the object-orinted tradition:
 *    * encapsulation
 *    * polymorphism
 *    * inheritance » creates more tangle
 */

/*******************************************************************************
 * The instanceof operator
 */

// console.log(new SymmetricMatrix(2) instanceof SymmetricMatrix);
//  » true
// console.log(new SymmetricMatrix(2) instanceof Matrix);
//  » true
// console.log(new Matrix(2, 3) instanceof SymmetricMatrix);
//  » false
// console.log([1] instanceof Array);
//  » true

