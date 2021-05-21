# Custom Authentication Strategies [↗] ![45.45%](https://progress-bar.dev/45/)

### Goals

Build upon the app completed in [the previous chapter][04-intro-to-auth].

1. Build a custom authentication flow.
1. Understand the _logic_ and _state_ needed to manage a custom authentication form.

   | Preconfigured               | Custom                                                                        |
   | --------------------------- | ----------------------------------------------------------------------------- |
   | The `withAuthenticator` HOC | Custom forms for signing up, signing in, and resetting passwords.             |
   | Protected routes            | Hook to wrap any component that needs to be protected with authentication.    |
   | The `Auth` class            | Continue using it together with React to manage a custom authentication form. |

<details>
  <summary>Screenshot</summary>

![FSS#05 Custom Authentication Strategies](https://user-images.githubusercontent.com/511893/119075105-3e97e980-b9be-11eb-95e6-1d256364b8cf.png))

</details>

### Extra takeaways

- As of React v17, `e.persist()` doesn’t do anything because the `SyntheticEvent` is [no longer pooled][react-v17-no-event-pooling].
- **Q:** Why name a component `ForgotPassword` if it enables the user to act and `ResetPassword`?

  - **A:** Because that's what the method on the `Auth` class from AWS Amplify is called. Is this reason enough though? 🤔

- Amplify has a _local eventing system_ called `Hub`.

  [↗]: https://learning-oreilly-com.ezproxy.torontopubliclibrary.ca/library/view/full-stack-serverless/9781492059882/ch05.html
  [04-intro-to-auth]: 04-intro-to-auth
  [react-v17-no-event-pooling]: https://reactjs.org/blog/2020/08/10/react-v17-rc.html#no-event-pooling
