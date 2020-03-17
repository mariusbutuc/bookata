/**
 * Build an automaton: a mail-delivery robot picking up and dropping off parcels
 */

/**
 * The village of Meadowfield: 11 places with 14 roads between them.
 */
const roads = [
  "Alice's House-Bob's House",
  "Alice's House-Cabin",
  "Alice's House-Post Office",
  "Bob's House-Town Hall",
  "Daria's House-Ernie's House",
  "Daria's House-Town Hall",
  "Ernie's House-Grete's House",
  "Grete's House-Farm",
  "Grete's House-Shop",
  "Marketplace-Farm",
  "Marketplace-Post Office",
  "Marketplace-Shop",
  "Marketplace-Town Hall",
  "Shop-Town Hall"
];

/**
 * Build a graph data structure that, for each place, tells us what can be
 * reached from there.
 *
 * The network of roads in the village forms a graph: a collection of
 *    * points (places in the village) with
 *    * lines between them (roads)
 *
 * @param {string[]} edges - an array of edges, the road strings, which have
 *    the form "Start-End"
 * @returns {Object} a map object(*) that, for each node, stores an array of
 *    connected nodes
 *
 * TODO: (*)is it a map object? Refactor to turn it into a Map?
 *        https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map
 * TODO: Explore documentation: how much domain/business logic (village, roads
 *        etc) does seep into the jsdoc of the fairly generic/abstract function
 *        that builds the graph?
 */
function buildGraph(edges) {
  // Ensure that no accidental/default keys are being "inherited" from the
  // `Object`'s prototype.
  let graph = Object.create(null);

  function addEdge(from, to) {
    if (graph[from] == null) {
      graph[from] = [to];
    } else {
      graph[from].push(to);
    }
  }

  for (let [from, to] of edges.map(r => r.split("-"))) {
    addEdge(from, to);
    addEdge(to, from);
  }

  return graph;
}

const roadGraph = buildGraph(roads);
// console.log(roadGraph);
// [Object: null prototype] {
//   'Alice\'s House': [ 'Bob\'s House', 'Cabin', 'Post Office' ],
//   'Bob\'s House': [ 'Alice\'s House', 'Town Hall' ],
//   Cabin: [ 'Alice\'s House' ],
//   'Post Office': [ 'Alice\'s House', 'Marketplace' ],
//   'Town Hall': [ 'Bob\'s House', 'Daria\'s House', 'Marketplace', 'Shop' ],
//   'Daria\'s House': [ 'Ernie\'s House', 'Town Hall' ],
//   'Ernie\'s House': [ 'Daria\'s House', 'Grete\'s House' ],
//   'Grete\'s House': [ 'Ernie\'s House', 'Farm', 'Shop' ],
//   Farm: [ 'Grete\'s House', 'Marketplace' ],
//   Shop: [ 'Grete\'s House', 'Marketplace', 'Town Hall' ],
//   Marketplace: [ 'Farm', 'Post Office', 'Shop', 'Town Hall' ] }

class VillageState {
  /**
   * Creates an instance of VillageState.
   *
   * @param {string} place - the robot’s current location.
   * @param {string[]} parcels - the collection of undelivered parcels, each of
   *    which has a current location and a destination address.
   *
   * @memberof VillageState
   */
  constructor(place, parcels) {
    this.place = place;
    this.parcels = parcels;
  }

  /**
   * Create a new `VillageState` to represent the state of the village if the
   * move is valid.
   *  * the `destination` is the robot's new `place` — the robot has `move`d to
   *      the `destination`.
   *  * a new set of `parcels` is being created:
   *    * move along the `parcels` that the robot is carrying to the new place.
   *    * deliver the parcels addressed to the new place — remove them from the
   *      set of undelivered parcels.
   *
   * @param {string} destination - the `destination` to `move` to, if there is a
   *    road going from the current `place` to it.
   * @returns `VillageState` - new state with the `destination` as the robot's
   *    new `place`.
   * @memberof VillageState
   */
  move(destination) {
    // TODO: Do we want to rely on `roadGraph` being declared in global scope?
    // TODO: Evaluate extracting a `isValidMove()` function to reduce cognitive
    //    load.
    if (!roadGraph[this.place].includes(destination)) {
      return this;
    } else {
      let parcels = this.parcels.map(parcel => {
        if (parcel.place != this.place) return parcel;
        return {place: destination, address: parcel.address};
      }).filter(parcel => parcel.place != parcel.address);

      return new VillageState(destination, parcels);
    }
  }
}

let first = new VillageState(
  "Post Office",
  [{place: "Post Office", address: "Alice's House"}]
);
let next = first.move("Alice's House");

console.log(next.place);
// » "Alice's House"
console.log(next.parcels);
// » []
console.log(first.place);
// » "Post Office"
