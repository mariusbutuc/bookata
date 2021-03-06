/**
 * Groups
 *
 * The standard JavaScript environment provides another data structure called
 * `Set`. Like an instance of `Map`, a set holds a collection of values.
 * Unlike `Map`, it does not associate other values with those—it just tracks
 * which values are part of the set. A value can be part of a set only
 * once—adding it again doesn’t have any effect.
 *
 * Write a class called `Group` (since `Set` is already taken). Like `Set`, it
 * has `add`, `delete`, and `has` methods. Its constructor creates an empty
 * group, `add` adds a value to the group (but only if it isn’t already a
 * member), `delete` removes its argument from the group (if it was a member),
 * and `has` returns a Boolean value indicating whether its argument is a member
 * of the group.
 *
 * Use the `===` operator, or something equivalent such as `indexOf`, to
 * determine whether two values are the same.
 *
 * Give the class a static `from` method that takes an iterable object as
 * argument and creates a group that contains all the values produced by
 * iterating over it.
 */

class Group {
  constructor() {
    this.values = [];
  }

  initialAdd(element) {
    if (this.values.indexOf(element) === -1) {
      this.values.push(element)
    }
  }

  initialHas(element) {
    return this.values.indexOf(element) >= 0
  }

  initialDelete(element) {
    if (this.initialHas(element)) {
      let elementIndex = this.values.indexOf(element);
      this.values.splice(elementIndex, 1);
    }
  }

  add(element) {
    if (!this.has(element)) {
      this.values.push(element)
    }
  }

  delete(element) {
    if (this.has(element)) {
      let remainingValues = this.values.filter(groupElement => groupElement != element)
      this.values = remainingValues;
    }
  }

  has(element) {
    return this.values.includes(element);
  }

  static from(iterable) {
    let group = new Group();

    for (let element of iterable) {
      group.add(element);
    }

    return group;
  }

}

let group = Group.from([10, 20]);
console.log('Expect true:', group.has(10));
console.log('Expect false:', group.has(30));
group.add(10);
group.delete(10);
console.log('Expect false:', group.has(10));
