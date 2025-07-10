# display with icons
alias ls="eza --grid --icons -a"
# tree view
alias lt="eza --icons -a --tree"

# force confirm
alias rm='rm -i'

# better git graph
alias gl="git log --all --graph --oneline"
alias gc="git checkout"
alias gb="git blame -w -C -C -C"

# better cat
alias cat="bat"

# display paths on separate lines
alias paths="echo $PATH | tr ':' '\n'"

function gm() {
  main_branch=$(basename $(git symbolic-ref refs/remotes/origin/HEAD))

  current_branch=$(git branch --show-current)
  if [[ "$main_branch" != "$current_branch" ]]; then
    git checkout $main_branch 
  fi

  git pull
}


# jj shortcuts
alias jp="jj git push --allow-new"
alias js="jj squash && jj git push"
jm() {
  jj git fetch && jj new $(basename $(git symbolic-ref refs/remotes/origin/HEAD))
}
jt() {
  jj b t $(jj log --no-graph -r @- -T 'remote_bookmarks.filter(|b| b.remote() == "origin")')
}
add-jj() {
    jj git init --colocate && jj b t "$(get-main-branch)@origin"
}
ghpr() {
  gh pr view $(jj log --no-graph -r 'heads(::@- & bookmarks())' -T 'bookmarks') -w
}

stacks() {
  jjui -r 'bookmarks() & ::~(git_head() | ~mine())'
}

diff() {
  jj diff -r 'trunk()..@'
}