/**
 * Data Transformations
 */

const schools = ["Yorktown", "Washington & Liberty", "Wakefield"];

// Array.join
// console.log(schools.join(", ")); // Yorktown, Washington & Liberty, Wakefield

// Array.filter
const wSchools = schools.filter((school) => school[0] === "W");
// console.log(wSchools); // [ 'Washington & Liberty', 'Wakefield' ]

// Pure function
const cutSchool = (cut, list) => list.filter((school) => school !== cut);
// console.log(cutSchool("Washington & Liberty", schools)); // [ 'Yorktown', 'Wakefield' ]

// Array.map
// Use case: A pure function that changes one object in an array of objects.
let schoolObjects = [
  { name: "Yorktown" },
  { name: "Stratford" },
  { name: "Washington & Liberty" },
  { name: "Wakefield" },
];
const editName = (oldName, newName, schools) =>
  schools.map((school) =>
    school.name === oldName ? { ...school, name: newName } : school
  );
const updatedSchoolObjects = editName(
  "Stratford",
  "HB Woodlawn",
  schoolObjects
);
// console.log({ newName: updatedSchoolObjects[1].name }); // { newName: 'HB Woodlawn' }
// console.log({ oldName: schoolObjects[1].name }); // { oldName: 'Stratford' }

// Use case: Transform object structure for more refined semantics, with the help of `Object.keys`
const schoolWinsData = {
  Yorktown: 10,
  "Washington & Liberty": 2,
  Wakefield: 5,
};
const schoolWins = Object.keys(schoolWinsData).map((name) => ({
  name,
  wins: schoolWinsData[name],
}));
// console.log(schoolWins);
// [
//   { name: 'Yorktown', wins: 10 },
//   { name: 'Washington & Liberty', wins: 2 },
//   { name: 'Wakefield', wins: 5 }
// ]

// Use case: Join/mashup arrays of data, with the help of `Object.keys`
const wins = [10, 4, 6];
const schoolWinsJoin = Object.keys(wins).map((index) => ({
  name: schools[index],
  wins: wins[index],
}));
// console.log(schoolWinsJoin);
// [
//   { name: 'Yorktown', wins: 10 },
//   { name: 'Washington & Liberty', wins: 4 },
//   { name: 'Wakefield', wins: 6 }
// ]

// Array.reduce
// Use case: Find the maximum number in an array
const ages = [21, 18, 42, 40, 64, 63, 34];
const maxAge = ages.reduce((max, age) => {
  return age > max ? age : max;
});
// console.log(maxAge); // 64

// Use case: Transform an array (that contains colours) into a [hash](https://en.wikipedia.org/wiki/Hash_function)
const colours = [
  {
    id: "xekare",
    title: "rad red",
    rating: 3,
  },
  {
    id: "jbwsof",
    title: "big blue",
    rating: 2,
  },
  {
    id: "prigbj",
    title: "grizzly grey",
    rating: 5,
  },
  {
    id: "ryhbhsl",
    title: "banana",
    rating: 1,
  },
];
const hashColours = (hash, colour) => {
  const { id, title, rating } = colour;

  return { ...hash, [id]: { title, rating } };
};
const coloursHash = colours.reduce(hashColours, {});
// console.log(coloursHash);
// {
//   xekare: { title: 'rad red', rating: 3 },
//   jbwsof: { title: 'big blue', rating: 2 },
//   prigbj: { title: 'grizzly grey', rating: 5 },
//   ryhbhsl: { title: 'banana', rating: 1 }
// }

// Use case: Deduplicate values in an array
const duplicateColours = ["red", "red", "green", "blue", "green"];
const deduplicate = (uniques, item) => {
  return uniques.includes(item) ? uniques : [...uniques, item];
};
const uniqueColours = duplicateColours.reduce(deduplicate, []);
// console.log(uniqueColours); // [ 'red', 'green', 'blue' ]
