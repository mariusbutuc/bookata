/**
 * Async/Await
 *
 *  » async: makes the function asynchronous that can wait for promises to resolve before executing the code any further
 *  » await: wait for the promise to resolve first.
 */
const fetch = require("node-fetch");

const getRandomUser = async () => {
  try {
    let res = await fetch("https://api.randomuser.me/?nat=CA&results=1");
    let { results } = res.json();
    console.log(results);
  } catch (error) {
    console.error(error);
  }
};

getRandomUser();
