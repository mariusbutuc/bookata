# Serverless Functions In-Depth: Part 1 [↗] ![54.54%](https://progress-bar.dev/54/)

### Goals

In [Chapter 2][02-getting-started], we created and interacted with a **serverless API** using API Gateway and AWS Lambda.

Here we'll explore two new types of serverless functions:

1. A function that dynamically adds a user to a group based on their email address

   - **Scenario:** "Coarse-grained" access control.

     - Grant certain permissions to users based on the type of _role_ or _group_ they are associated with.

   - Depending on the email address used during signup, a user either belongs to an _Admin_ group or not.

1. A function that automatically resizes an image after it has been uploaded to Amazon S3

   - **Scenario:** Once a user uploads an image, dynamically resize the image on the server.
     - Compress images for performance, dynamically create thumbnails or avatar images, etc.

Instead of using the serverless functions as strictly a web server or an API, they will be used to interact with other AWS services to aid in the application-development process.

<details>
  <summary>Screenshot</summary>

![FSS#06 Serverless Functions In-Depth: Part 1](https://user-images.githubusercontent.com/511893/120945321-921c6e00-c706-11eb-8c23-a63b618689fe.png)

</details>

### Extra takeaways

- Event-based architecture: different event sources emit different event types with different shapes of data / data structures. This also reflects in the data available in the event.

#### Adding a Post-Confirmation Lambda Trigger

Functionality to be added:

1. Create an authentication service ([`amplify add auth`](https://github.com/mariusbutuc/bookata/pull/19/commits/3dd171f)).
1. Create and configure a post-confirmation Lambda trigger.
   - Invoke the Lambda function every time someone signs up and successfully confirms their account using the authentication service.
   - 💡 _As simple as creating the authentication service with the right configuration through Amplify CLI._
1. Add the new user to the group called `Admins` if their email attribute is [included in the `adminEmails` array](https://github.com/mariusbutuc/bookata/pull/19/commits/2ac6ac8).
1. Greet the user [if they are an Admin](https://github.com/mariusbutuc/bookata/pull/19/commits/49f16d8).

#### Dynamic Image Resizing with AWS Lambda and Amazon S3

Functionality to be added:

1. Upload images to S3 (using the `Storage` API).
1. Configure S3 trigger to call Lambda function on every new file upload to bucket.

   - 💡 _As simple as creating the S3 bucket with the right configuration through Amplify CLI._

1. Resize image to fit below the width threshold (using the `sharp` library).

[↗]: https://learning-oreilly-com.ezproxy.torontopubliclibrary.ca/library/view/full-stack-serverless/9781492059882/ch06.html
[02-getting-started]: 02-getting-started
