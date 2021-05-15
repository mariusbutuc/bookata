# [Getting Started with AWS Amplify][↗️] ![18.18%](https://progress-bar.dev/18/)

### Goals:

1. Create and deploy a simple serverless function (**Lambda function**) that returns a static array.
2. Add a (REST) API (**Amazon API Gateway**).
3. Interact with the API via the Amplify client library.
4. Update the serverless function to asynchronously **fetch dynamic data** from an [external API].

<details><summary>Screenshot</summary>
<p>

![React_App](https://user-images.githubusercontent.com/511893/117550403-329b4780-b00e-11eb-94f1-f19dd5d2a67e.png)

</p>
</details>

### Takeaways

- **Lambda functions**
  - are self-contained Node.js applications—here we ran an express application to handle a REST `get`.
  - can be triggered from a variety of events—here we used an API call from API Gateway.
- A single **API Gateway** endpoint can handle multiple Lambda functions.
- The `API` _category_ from the Amplify client library can be used with both GraphQL as well as REST APIs.

### Extra:

- Giving up on exploring **Yarn 2 Modern**, for now.

  - PR opened after #14 in the meantime: https://github.com/aws-amplify/amplify-js/pull/8219

  [↗️]: https://learning-oreilly-com.ezproxy.torontopubliclibrary.ca/library/view/full-stack-serverless/9781492059882/ch02.html
  [external api]: https://www.coinlore.com/cryptocurrency-data-api
