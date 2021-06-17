/**
 * Immutability
 */

let color_lawn = {
  title: "lawn",
  color: "#00FF00",
  rating: 0,
};

// First, what does it mean to mutate data?
function rateMutatingColor(color, rating) {
  // In JS, function arguments are references to the actual data.
  color.rating = rating;
  return color;
}
// console.log(rateMutatingColor(color_lawn, 5).rating); // 5
// console.log(color_lawn.rating); // 5

// Now, let's rewrite the function so that it does not harm the original data.
const rateImmutableColor = function (color, rating) {
  return Object.assign({}, color, { rating });
};
// console.log(rateImmutableColor(color_lawn, 5).rating); // 5
// console.log(color_lawn.rating); // 0

const rateImmutableColorAlternative = (color, rating) => ({
  ...color,
  rating,
});
// console.log(rateImmutableColorAlternative(color_lawn, 5).rating); // 5
// console.log(color_lawn.rating); // 0

// ⚠️ The spread operator can add new, inexistent properties to the object.
// Contrast this behaviour with the "update operator" from other languages e.g., Elixir
const rateTypo = (color, rafting) => ({
  ...color,
  rafting,
});
// console.log(rateTypo(color_lawn, 42)); // { title: 'lawn', color: '#00FF00', rating: 0, rafting: 42 }
