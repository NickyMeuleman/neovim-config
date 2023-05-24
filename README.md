# Neovim config

Uses several different sources as inspiration:

- https://www.youtube.com/watch?v=ctH-a-1eUME
- https://github.com/LunarVim/nvim-basic-ide
- https://www.youtube.com/watch?v=vdn_pKJUda8
- https://github.com/josean-dev/dev-environment-files/tree/main/.config/nvim
- https://www.youtube.com/watch?v=stqUbv-5u2s
- https://github.com/nvim-lua/kickstart.nvim
- https://www.youtube.com/watch?v=w7i4amO_zaE
- https://github.com/ThePrimeagen/init.lua
- https://www.youtube.com/watch?v=J9yqSdvAKXY
- https://github.com/cpow/cpow-dotfiles
- https://www.youtube.com/watch?v=Hg8dhwsddlM
- https://github.com/dane-harnett/dotfiles

And LOTS of help from the Vim channel in The ThePrimeagen's Discord.

I'm swiching from VSCode to Neovim so expect several setting that are tailored to preserving my habits partially.

alternative way to set up LSPs detailed here:
https://github.com/williamboman/mason.nvim/discussions/57#discussioncomment-3129035

### Notes

https://github.com/folke/trouble.nvim
to replace my usage of the "problems" panel in vscode.

Should I do an integrated terminal, use my termial app's splits and tabs, or go full on tmux?

Breadcrumbs via lspsaga or barbecue?
VSCodelike tab pages: barbar or bufferline?

I want the autofix behaviour of ESLint from VSCode codeactions.fixall, or the --fix command line arg.
Do I need to drop eslint_d from null-ls and use eslint through lspconfig like so: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint?

[x] : extract formatting logic so the on_attach for an lspconfig lsp,
a null-ls source, and the keymap for formatting use the same logic
Based on: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/format.nvim-lua

Well, that extraction caused a weird intermittant error.
I think it's a race condition to do with null-ls not being loaded on vim startup.

```
Error detected while processing BufEnter Autocommands for "*":
Failed to run `config` for null-ls.nvim
/home/nicky/.config/nvim/lua/nicky/plugins/null-ls.lua:14: loop or previous erro
r loading module 'nicky.utils'
# stacktrace:
  - ~/.config/nvim/lua/nicky/plugins/null-ls.lua:14 _in_ **config**
  - ~/.config/nvim/lua/nicky/utils/init.lua:3
  - ~/.config/nvim/lua/nicky/plugins/lspconfig.lua:21 _in_ **config**
  - ~/.config/nvim/lua/nicky/lazy.lua:25
  - ~/.config/nvim/init.lua:#
```

Reordered some code and it appears to be fixed now since I can no longer replicate it.

Todo: make a toggle that turns autoformatting on or off
