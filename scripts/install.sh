#!/bin/bash

for pkg in neovim starship ripgrep fzf bat exa fnm dust lf
do
	brew install "$pkg"
done

npm i -g tldr