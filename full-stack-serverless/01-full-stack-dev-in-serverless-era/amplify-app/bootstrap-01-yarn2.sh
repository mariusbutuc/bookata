set -e

# Enable Yarn 2 (Modern) for this project
yarn set version berry

# Editor setup for VSCode
yarn dlx @yarnpkg/pnpify --sdk vscode

yarn add --dev eslint
yarn add --dev prettier

yarn dlx @yarnpkg/doctor
