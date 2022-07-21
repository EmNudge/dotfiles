# Dotfiles

Currently this is Unix only. Have yet to have a usecase where WSL wasn't possible, so this will break on plain windows.

## Neovim

1. install [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim) > 0.7
2. install [Packer](https://github.com/wbthomason/packer.nvim#quickstart)
3. move config or simlink with `ln -s ./nvim ~/.config/nvim`
4. Install desired LSP servers with `:LspInstall <servers>`
