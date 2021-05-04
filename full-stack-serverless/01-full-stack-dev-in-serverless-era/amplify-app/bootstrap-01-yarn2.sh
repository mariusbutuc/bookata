set -e

# Enable Yarn 2 (Modern) for this project
yarn set version berry

# Editor setup for VSCode
yarn dlx @yarnpkg/pnpify --sdk vscode

yarn add --dev eslint
yarn add --dev prettier

# https://github.com/facebook/create-react-app/issues/10463#issuecomment-813702443
yarn add eslint-config-react-app

yarn dlx @yarnpkg/doctor
