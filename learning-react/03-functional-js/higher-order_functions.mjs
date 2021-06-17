import getPeople from "./../02-js-for-react/promises.mjs";

/**
 * Higher-order Functions and Currying
 */
const MEMBERS_COUNT = 20;
const userLogs = (userName) => (message) =>
  console.log(`${userName} -> ${message}`);
const log = userLogs("atlistBot");

log(`attempted to load ${MEMBERS_COUNT} fake members`);
getPeople(MEMBERS_COUNT).then(
  (members) => log(`Successfully loaded ${members.length} members`),
  (error) => log(`Encountered an error loading members: ${error.message}`)
);
