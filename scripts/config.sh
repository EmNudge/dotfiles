#!/bin/bash

# branch view is column
git config --global column.ui auto
git config --global branch.sort -committerdate

# enable merge conflict resolution memory
git config --global rerere.enabled true

# fix long `git status` issue
git config --global core.untrackedcache true
git config --global core.fsmonitor true

# sign with SSH (do not enable by default)
# git config --global gpg.format ssh
# git config --global user.signinkey ~/.ssh/key.pub
