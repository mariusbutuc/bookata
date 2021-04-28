set -e

# 1. Install the Amplify CLI
PACKAGE="@aws-amplify/cli"
npm list -g $PACKAGE || npm install -g $PACKAGE

# 2. Configure it with an identity and access management (IAM) user in your AWS account.
#    To create a new user and configure the CLI, run the `configure` command:
amplify configure
# ~/.aws/config
# region: us-east-1
# user name: amplify-cli-us-east-1-user

# ~/.aws/credentials
# aws_access_key_id
# aws_secret_access_key

# ~/.aws/{config, credentials}
# profile name: marius-amplify
