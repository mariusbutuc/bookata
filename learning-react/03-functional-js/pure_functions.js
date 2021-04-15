/**
 * Pure functions
 */

const frederick = {
  name: "Frederick Douglass",
  canRead: false,
  canWrite: false,
};

// First, what does it mean for a function to be impure?
function selfEducate() {
  // once this function is invoked, something about the "world" has changed.
  frederick.canRead = true;
  frederick.canWrite = true;
  return frederick;
}
// selfEducate();
// console.log(frederick); // { name: 'Frederick Douglass', canRead: true, canWrite: true }

// The pure function alternative:
//  1. Accesses via arguments everything it needs to operate.
//  2. Treats its arguments as immutable data: it does not mutate the objects sent to it.
//  3. Causes no side effects whatsoever.
const selfEducatePure = (person) => ({
  ...person,
  canRead: true,
  canWrite: true,
});
// console.log(selfEducatePure(frederick)); // { name: 'Frederick Douglass', canRead: true, canWrite: true }
// console.log(frederick); // { name: 'Frederick Douglass', canRead: false, canWrite: false }
