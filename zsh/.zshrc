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

# pull in functions: zsh_add_file, zsh_add_plugin, zsh_add_completion
source "$HOME/.config/zsh/functions.zsh"

zsh_add_file 'vi-mode'
zsh_add_file 'aliases'
zsh_add_file 'paths'

zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-completions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

zsh_add_completion "git/git/blob/master/contrib/completion/git-completion.zsh"
compinit

# pnpm
export PNPM_HOME="/Users/worker/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/Users/worker/.bun/_bun" ] && source "/Users/worker/.bun/_bun"
