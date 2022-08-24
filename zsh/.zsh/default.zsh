#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude '.git' --exclude '.svn' --exclude 'node_modules'"
export FZF_DEFAULT_OPTS="--layout=reverse --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude ".git"'

_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_path() {
    fd --type f --hidden --follow --exclude ".git" . "$1"
}
