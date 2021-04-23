/**
 * Promise
 *
 * An object that represents whether the async operation
 *  » is pending,
 *  » has been completed, or
 *  » has failed.
 */
import fetch from "node-fetch";
import XMLHttpRequest from "xhr2";

// console.log(fetch("https://api.randomuser.me/?nat=CA&results=1"));
// Promise { <pending> }

/**
 * then() » invoke the callback if the previous operation was successful
 * catch() » invoke the callback if the `fetch` did not resolve successfully
 */
fetch("https://api.randomuser.me/?nat=CA&results=1")
  .then((res) => res.json())
  .then((json) => json.results)
  // .then(console.info)
  .catch(console.error);

// Build a Promise by hand
const getPeople = (count) =>
  new Promise((resolves, rejects) => {
    const api = `https://api.randomuser.me/?nat=CA&results=${count}`;
    const request = new XMLHttpRequest();
    request.open("GET", api);
    request.onload = () =>
      request.status === 200
        ? resolves(JSON.parse(request.response).results)
        : rejects(Error(request.statusText));
    request.onerror = (err) => rejects(err);
    request.send();
  });

getPeople(5)
  .then((members) => console.log(members))
  .catch((error) => console.error(`getPeople failed: ${error.message}`));

export default getPeople;
