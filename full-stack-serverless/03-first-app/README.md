# [Creating our First App][↗] ![27.27%](https://progress-bar.dev/27/)

### Goals

Build a notes app that will allow users to create, update, and delete notes.

1. Broaden understanding of **GraphQL** by creating a GraphQL API.
2. Use the GraphQL API to interact with a **DynamoDB** NoSQL database.
3. Use the GraphQL API to perform CRUD+L (create, read, update, delete, and list) operations.
4. Explore GraphQL subscriptions to see updates in **real time**.

<details><summary>Screenshot</summary>
<p>

![React_App](https://user-images.githubusercontent.com/511893/117908393-55e02400-b2a6-11eb-8796-8e117dfb0e17.png)

</p>
</details>

## GraphQL

### What is GraphQL?

- API specification
- Query language for APIs
- Runtime for fulfilling queries with the data
- Define the structure of data required from an API call

### What makes up a GraphQL API?

1. Schema

   - Written in GraphQL Schema Definition Language (SDL)
   - Defines
     - Data model / base types
     - Operations
       - Queries: fetch data.
         ```graphql
         query listNotes {
           listNotes(filter: { completed: { eq: false } }, limit: 1) {
             items {
               id
               name
               description
             }
           }
         }
         ```
       - Mutations: create, update, and delete data.
         ```graphql
         mutation createNote {
           createNote(
             input: {
               name: "Book flight"
               description: "Flying to Paris on June 1 returning June 10"
               completed: false
             }
           ) {
             id
             name
             description
             completed
           }
         }
         ```
       - Subscriptions: subscribe to changes in real time.

2. Resolvers

3. Data sources

#### GraphQL server

Leverage **AWS AppSync** to deploy the GraphQL API, resolvers, and data sources via the Amplify CLI.

#### The `@model` directive

Part of the AWS Amplify GraphQl Transform library, the `@model` directive expands the base type into an AWS AppSync GraphQL API, adding

1. Schema definitions for queries (Read, List)
2. Schema definitions for mutations (Create, Update, and Delete)
3. Schema definitions for subscriptions
4. DynamoDB database
5. Resolver code mapping all the GraphQL ops to the DynamoDB database

<details><summary>Screenshot</summary>
<p>

![React_App](https://user-images.githubusercontent.com/511893/117908393-55e02400-b2a6-11eb-8796-8e117dfb0e17.png)

</p>
</details>

## Takeaways

- [GraphQL scalar types]

  - The fields of GraphQL object types eventually resolve to _concrete data_. These are scalar types: the leaves of the query.

- The [`useReducer`] hook

  - `useReducer` is usually preferable to `useState` when you have _complex state logic_ that involves _multiple sub-values_ or when the next state depends on the previous one. `useReducer` also lets you optimize performance for components that trigger _deep updates_ because you can pass dispatch down instead of callbacks.

- Using the [Amplify GraphQL client] to fetch data: `API.graphql(…)`

- Leveraging the Ant Design [`List` component]

- Optimistic response

  > […] we are updating the local state before the API call is successful. […] It is done because we want the UI to be fast and to update as soon as the user adds a new note.
  >
  > If the API call fails, you can then implement some functionality in the `catch` block to notify the user […]

### List Notes (GraphQL query)

- the `useReducer` hook
- Using the Amplify GraphQL client to fetch data: `API.graphql(…)`
- the Ant Design `List` component

### Create Notes (GraphQL mutation)

- the form to create a new note
- the function to update the state as the user types into the form
- the function to
  - add the new note to the UI and
  - send an API call to create a new note

### Delete Notes (GraphQL mutation)

- `deleteNote` function to delete the note both
  - from the UI and
  - from the GraphQL API
- button in each note to invoke `deleteNote`.

### Update Notes (GraphQL mutation)

- `updateNote` function to update the note
  - in the UI and
  - in the GraphQL API
- button in each note to invoke `updateNote`.

### Real-Time Data (GraphQL subscriptions)

Add ability to subscribe to updates in real time: adding a new Note.

- the app receives the new Note
- update the Notes array with the new Note
- render the updated notes array on the screen

  [↗]: https://learning-oreilly-com.ezproxy.torontopubliclibrary.ca/library/view/full-stack-serverless/9781492059882/ch03.html
  [`list` component]: https://ant.design/components/list/
  [`usereducer`]: https://reactjs.org/docs/hooks-reference.html#usereducer
  [amplify graphql client]: https://docs.amplify.aws/lib/graphqlapi/query-data/q/platform/js
  [graphql scalar types]: https://graphql.org/learn/schema/#scalar-types
