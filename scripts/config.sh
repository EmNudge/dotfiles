#!/bin/bash

# branch view is column
git config --global column.ui auto
git config --global branch.sort -committerdate

# enable merge conflict resolution memory
git config --global rerere.enabled true

# fix long `git status` issue
git config --global core.untrackedcache true
git config --global core.fsmonitor true
