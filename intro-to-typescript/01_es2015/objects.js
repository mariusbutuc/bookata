/**
 * ## Objects and arrays
 *
 *  * object destructuring - access parts of an object ot array
 *      * easier than "dot walking"
 */

const friend = {
    name: 'Steve',
    age: 30,
    hobbies: ['water polo', 'reading']
};

// Pre-ES6: dot walking
// const name = friend.name;
// console.log(name);
// » Steve

/**
 * ### Object destructuring allows for
 *  * binding multiple variables at the same time
 *  * brevity when the property name and variable name to be bound are the same
 *  * aliases when the variable is to be named something else than the property name
 */
const { name: firstName, age } = friend;
// console.log(firstName, age);
// » Steve 30



const numbers = [0, 1, 2];
const [firstElement] = numbers;
// console.log(firstElement);
// » 0



const response = {
    count: 10,
    data: [{
        name: 'Luke Skywalker',
        films: ['Empire Strikes Back', 'The Force Awakens']
    }, {
        name: 'Han Solo',
        films: ['A New Hope']
    }]
};

const { count, data: [{ films }] } = response;
// console.log(films);
// » [ 'Empire Strikes Back', 'The Force Awakens' ]

response.data.forEach(data_item => {
    let { name } = data_item;
    // console.log(name)
})
// » Luke Skywalker
// » Han Solo



/**
 * ### The "property value shorthand" pattern
 *
 *  * only specify the name once if the property name and name of the variable
 *    to be bound are the same
 */
const name = 'Steve';
const retirementAge = 30;

// Before
const person = {
    name: name,
    retirementAge: retirementAge
}

// After
const samePerson = {
    name,
    retirementAge
}



/**
 * ### Computed property keys
 *
 *  * only specify the name once if the property name and name of the variable
 *    to be bound are the same
 */
function nameMe(name) {
    return {
        [name.toLowerCase()]: {
            message: `My name is ${name}`
        }
    };
}

console.log(
    nameMe('Steve')
);
