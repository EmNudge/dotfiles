#!/bin/bash

# branch view is column
git config --global column.ui auto
git config --global branch.sort -committterdate

# enable merge conflict resolution memory
git config --global rerere.enabled true

# fix long `git status` issue
git config --global core.untrackedcache true
git config --global core.fsmonitor true

# sign with SSH (do not enable by default)
# git config --global gpg.format ssh
# git config --global user.signinkey ~/.ssh/key.pub

# built in aliases
git config --global alias.staash 'stash --all'
git config --global alias.l 'log -L' # e.g. :File:path/to/file
git config --global alias.d 'diff --word-diff'