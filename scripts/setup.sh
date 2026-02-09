#!/bin/bash

# Clone Astro, but remove tracking so as not to commit it
git clone --depth 1 https://github.com/AstroNvim/template AstroNvim && rm -rf AstroNvim/.git

# symlink
ln -s "$(pwd)"/AstroNvim ~/.config/nvim
ln -s "$(pwd)"/zsh ~/.config/zsh

# add zshrc to .zshrc
echo "source ~/.config/zsh/.zshrc" >> ~/.zshrc

# Claude Code config
mkdir -p ~/.claude/commands
ln -sf "$(pwd)"/claude/claude.md ~/.claude/claude.md
for cmd in "$(pwd)"/claude/commands/*.md; do
	ln -sf "$cmd" ~/.claude/commands/
done