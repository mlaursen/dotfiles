# dotfiles

This repo contains my dotfiles.

- [Mac Installation](./install/mac/README.md)
- [Windows Installation](./install/windows/README.md)

Install [nerd fonts](https://github.com/ryanoasis/nerd-fonts) that include
icons.

- [DejaVuSansMono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/DejaVuSansMono.zip)

```sh
bash <(curl -s https://raw.githubusercontent.com/mlaursen/dotfiles/master/init.sh)
```

> Note: Check out
> [Methods of Signing with GPG](https://gist.github.com/troyfontaine/18c9146295168ee9ca2b30c00bd1b41e)

## GraphQL

```
:Mason
# find and install graphql lsp
```

Since the graphql-lsp causes symbol lookups to fail in `.ts`/`.tsx` files, only
add the graphql lsp to those specific workspaces in a local
`.vim/coc-settings.json`:

```json
{
  "languageserver": {
    "graphql": {
      "command": "graphql-lsp",
      "args": ["server", "-m", "stream"],
      "filetypes": ["typescript", "typescriptreact", "graphql"]
    }
  }
}
```

## Useful things

### Find all unique occurrences with grep

```sh
grep -r --only-matching -h -E '{{REGEX}}' {{DIRECTORY}} | sort --unique
```

Example:

```sh
grep -r --only-matching -h -E '<([A-z]+Icon).* />' "react-md/packages/*/src" | sort unique
```
