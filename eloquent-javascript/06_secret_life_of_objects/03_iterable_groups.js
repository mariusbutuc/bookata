class Group {
  constructor() {
    this.values = [];
  }

  add(element) {
    if (!this.has(element)) {
      this.values.push(element);
    }
  }

  delete(element) {
    if (this.has(element)) {
      let remainingValues = this.values.filter(
        groupElement => groupElement != element
      );
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

/**
 * Iterable groups
 *
 * Make the `Group` class from the previous exercise iterable. Refer to the
 * section about the iterator interface earlier in the chapter if you aren’t
 * clear on the exact form of the interface anymore.
 *
 * If you used an array to represent the group’s members, don’t just return the
 * iterator created by calling the `Symbol.iterator` method on the array. That
 * would work, but it defeats the purpose of this exercise.
 *
 * It is okay if your iterator behaves strangely when the group is modified
 * during iteration.
 */
class GroupIterator {
  constructor(group) {
    this.index = 0;
    this.values = group.values;
  }

  next() {
    if (this.values.length === 0) return {done: true};

    let value = this.values.shift();
    return {value, done: false};
  }
}

Group.prototype[Symbol.iterator] = function() {
  return new GroupIterator(this);
}

let group = Group.from(["a", "b", "c"]);
for (let value of group) {
  console.log(value);
}
// → a
// → b
// → c
