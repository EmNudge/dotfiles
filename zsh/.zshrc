# highlighting
autoload -Uz colors && colors
# shell prompt
eval "$(starship init zsh)"


# extend history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history


# tab completion
autoload -Uz compinit
zstyle ":completion:*" menu select
zstyle ":completion:*" matcher-list 'm:{a-z}={A-Za-z}'
zmodload zsh/complist
# also keep dotfiles in tab completion
_comp_option+=(globdots)


# use lf (Ctrl+o) to pick dirs
lfcd() {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
	dir="$(cat "$tmp")"
	rm -f "$tmp"
	[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s "^o" "lfcd\n"

export ZDOTDIR=$HOME/.config/zsh

source "$ZDOTDIR/vi-mode.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/paths.zsh"

zsh_add_plugin() {
	PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
	if [ ! -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
		git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME" --depth 1
	fi

	source "$ZDOTDIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
}

zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-completions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"


fpath+="$ZDOTDIR/completions"

if [[ ! -f "$ZDOTDIR/completions/git-completion.zsh" ]]; then 
    curl "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh" \
        --create-dirs -o "$ZDOTDIR/completions/git-completion.zsh"
    source "$ZDOTDIR/completions/git-completion.zsh"
fi

compinit

tmp() {
	local rand_name="r$(LC_ALL=C tr -dc a-z0-9 </dev/urandom | head -c 6)"
	local temp_folder="/tmp/trash-dirs/${1:+$1-}$rand_name"
	mkdir -p "$temp_folder" && cd "$temp_folder" || return 1
}

graduate() {
	folder_name=${1:-$(basename "$PWD")}

	new_path="$HOME/Workspace/$folder_name"
	if [ -d $new_path ]; then
       	echo "Error: Folder $new_path already exists. Aborting."
       	exit 1
	fi

	mv "$PWD" $new_path
	cd $new_path
}

q() {
  llm "$*" | bat --paging=never -p -l md
}

# move between recent branches
cb() {
	git branch -vv --sort=-committerdate --color \
	  | fzf --ansi --header Checkout \
		| cut -d' ' -f3 \
		| xargs git checkout
}

# get latest main branch
gm() {
	remote_head=$(git symbolic-ref refs/remote/origin/HEAD)
	main_branch=$(basename $remote_head)

	current_branch=$(git branch --show-current)
	if [[ "$main_branch" != "$current_branch" ]]; then
		git checkout $main_branch
	fi

	git pull
}