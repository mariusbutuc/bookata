/**
 * Object literal enhancement
 *
 * Restructuring or putting the object back together. Also works to create object methods.
 */
const name = "Tallac";
const elevation = 9738;
const print = function () {
  console.log(`Mt. ${this.name} is ${this.elevation} feet tall.`);
};

const funHike = { name, elevation, print };

funHike.print();
// Mt. Tallac is 9738 feet tall.
