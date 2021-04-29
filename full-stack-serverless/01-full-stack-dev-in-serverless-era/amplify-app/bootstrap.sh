set -e

yarn set version berry

# Editor setup for VSCode
yarn dlx @yarnpkg/pnpify --sdk vscode
