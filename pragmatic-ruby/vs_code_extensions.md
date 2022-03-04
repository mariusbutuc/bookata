# VS Code extensions + gems for the joy of Ruby

- [x] [Ruby](https://marketplace.visualstudio.com/items?itemName=rebornix.Ruby)

  ```sh
  ➜ gem install \
      reek \
      rubocop
  ```

  - Custom settings

    ```js
    {
      "ruby.format": "rubocop",
      "ruby.lint": {
        "reek": true,
        "rubocop": true
      },
      "ruby.useBundler": false,
      "ruby.useLanguageServer": true,
    }
    ```

    - [Example Initial Config](https://github.com/rubyide/vscode-ruby/blob/main/packages/vscode-ruby-client/README.md#example-initial-configuration)

- [x] [Ruby Solargraph](https://marketplace.visualstudio.com/items?itemName=castwide.solargraph)

  ```sh
  ➜ gem install solargraph
  ```

- [x] [endwise](https://marketplace.visualstudio.com/items?itemName=kaiwood.endwise)

- [x] [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner)

  - Custom settings

    ```js
    {
      "code-runner.clearPreviousOutput": true,
      "code-runner.runInTerminal": true,
      "code-runner.saveFileBeforeRun": true,
    }
    ```
