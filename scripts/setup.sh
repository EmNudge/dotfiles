#!/bin/bash

# Clone Astro, but remove tracking so as not to commit it.
git clone --depth 1 https://github.com/AstroNvim/AstroNvim && rm -rf AstroNvim/.git

# symlink
ln -s "$(pwd)"/AstroNvim ~/.config/nvim
ln -s "$(pwd)"/zsh ~/.config/zsh

# add zshrc to .zshrc
echo "source ~/.config/zsh/.zshrc" >> ~/.zshrc