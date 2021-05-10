# Creating Your First App

![27.27%](https://progress-bar.dev/27/)

### Goals:

Build a notes app that will allow users to create, update, and delete notes.

1. Broaden understanding of **GraphQL** by creating a GraphQL API.
2. Use the GraphQL API to interact with a **DynamoDB** NoSQL database.
3. Use the GraphQL API to perform CRUD+L (create, read, update, delete, and list) operations.
4. Explore GraphQL subscriptions to see updates in **real time**.

<details><summary>Screenshot</summary>
<p>

![React_App](https://user-images.githubusercontent.com/511893/117550403-329b4780-b00e-11eb-94f1-f19dd5d2a67e.png)

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
       - Mutations: create, update, and delete data.
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

## Extra

- [GraphQL scalar types]

  - The fields of GraphQL object types eventually resolve to _concrete data_. These are scalar types: the leaves of the query.

  [graphql scalar types]: https://graphql.org/learn/schema/#scalar-types
