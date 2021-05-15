# [Intro to Authentication][↗] ![36.36%](https://progress-bar.dev/36/)

### Goals

Using a combination of

- the Amplify CLI,
- Amplify JavaScript client, and
- Amplify React UI components,

build an application that demonstrates

- _routing_,
- _authentication_, and
- _protected routes_.

<details>
  <summary>Screenshot</summary>

![FSS#04 Intro to Authentication](https://user-images.githubusercontent.com/511893/118343020-608ff880-b4f4-11eb-9ac2-c160882b4421.png)

</details>

### Extra takeaways

- Deploying the authentication service using `amplify push` generates no artefacts to be peristed in source control.

- Two main ways to integrate the Auth service on the client:

  1. The `Auth` class: custom authentication flow
  1. Framework-specific authentication components: render an entire (customizable) authentication flow (e.g., the `withAuthenticator` HOC).

- Getting user profile data: `Auth.currentAuthenticatedUser` or `Auth.currentUserPoolUser`?

  - The docs describe both [`currentUserPoolUser`] and [`currentAuthenticatedUser`] very similarly, yet in the book one is referenced and then the other is used. This doesn't help reduce the blurriness between the two main Cognito pieces: _user pools_ and _identity pools_.
  - The [support knowledge article] trying to clarify this distinction also mentions that

    > _User pools_ are for _authentication_ (identify verification). […]

    yet at the same time one method has _user pool_ in its name while the other has _authenticated_. So I didn't find much help in clarifying the distinction here either.

  - Asking further: https://github.com/dabit3/full-stack-serverless-code/pull/91

- Under the hood, the **Amplify UI components** are implemented using **Web Components**.

  - This means we can target them as a first-class HTML element for CSS styling.

  [`currentauthenticateduser`]: https://aws-amplify.github.io/amplify-js/api/classes/authclass.html#currentauthenticateduser
  [`currentuserpooluser`]: https://aws-amplify.github.io/amplify-js/api/classes/authclass.html#currentuserpooluser
  [↗]: https://learning-oreilly-com.ezproxy.torontopubliclibrary.ca/library/view/full-stack-serverless/9781492059882/ch04.html
  [support knowledge article]: https://aws.amazon.com/premiumsupport/knowledge-center/cognito-user-pools-identity-pools/
