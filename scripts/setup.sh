#!/bin/bash

git clone --depth 1 https://github.com/AstroNvim/AstroNvim
ln -s "$(pwd)"/AstroNvim ~/.config/nvim
ln -s "$(pwd)"/zsh ~/.config/zsh
echo "source ~/.config/zsh/.zshrc" >> ~/.zshrc