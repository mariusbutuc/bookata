/**
 * Classes
 */

// Constructor function
function VacationConstructor(destination, length) {
  this.destination = destination;
  this.length = length;
}

VacationConstructor.prototype.print = function () {
  console.log(this.destination + " | " + this.length + " days");
};

/**
 *  Feels like a custom type in an object-oriented language
 *      » has properties: `destination` & `length`
 *      » has a method: `print`
 */
const romania = new VacationConstructor("Romania", 21);
romania.print(); // Romania | 21 days

// Class declaration
class Vacation {
  constructor(destination, length) {
    this.destination = destination;
    this.length = length;
  }

  print() {
    console.log(`${this.destination} will take ${this.length} days.`);
  }
}

const belarus = new Vacation("Belarus", 21);
belarus.print(); // Belarus will take 21 days.

class Expedition extends Vacation {
  constructor(destination, length, gear) {
    super(destination, length);
    this.gear = gear;
  }

  print() {
    super.print();
    console.log(`Bring your ${this.gear.join(" and your ")}`);
  }
}

const killarney = new Expedition("Killarney Provincial Park", 5, [
  "backpack",
  "sunglasses",
  "food",
]);
killarney.print();
// Killarney Provincial Park will take 5 days.
// Bring your backpack and your sunglasses and your food
