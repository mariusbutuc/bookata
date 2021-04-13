/**
 * Imperative JavaScript programming
 *
 * Mainly concerned with _how to_ achieve results with code.
 */
const string = "Vegetarian restaurants in East York";
let urlFriendly = "";

// Loop through every character of the string
for (var i = 0; i < string.length; i++) {
  // replace spaces as they occur
  if (string[i] === " ") {
    urlFriendly += "-";
  } else {
    urlFriendly += string[i];
  }
}

console.log(urlFriendly); // Vegetarian-restaurants-in-East-York
