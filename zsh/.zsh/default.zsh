# Find the correct command for fd-find and bat, and verify them.

_FZF_FD_CMD=""
# Prefer the unambiguous 'fdfind' command.
if command -v fdfind &> /dev/null; then
  _FZF_FD_CMD="fdfind"
  # If 'fdfind' exists and 'fd' command does NOT exist, create an alias for convenience.
  if ! command -v fd &> /dev/null; then
    alias fd='fdfind'
  fi
# If not found, check for 'fd' and verify it's the correct program.
elif command -v fd &> /dev/null && fd --version 2>/dev/null | grep -q 'fd'; then
  _FZF_FD_CMD="fd"
fi

_FZF_BAT_CMD=""
# Prefer the unambiguous 'batcat' command.
if command -v batcat &> /dev/null; then
  _FZF_BAT_CMD="batcat"
  # If 'batcat' exists and 'bat' command does NOT exist, create an alias for convenience.
  if ! command -v bat &> /dev/null; then
    alias bat='batcat'
  fi
# If not found, check for 'bat' and verify it's the correct program.
elif command -v bat &> /dev/null && bat --version 2>/dev/null | grep -q 'bat'; then
  _FZF_BAT_CMD="bat"
fi

# Only set fzf options if the required, VERIFIED commands were found.
# This prevents errors if another program is using the name 'fd' or 'bat'.
if [ -n "$_FZF_FD_CMD" ] && [ -n "$_FZF_BAT_CMD" ]; then

  export FZF_DEFAULT_COMMAND="$_FZF_FD_CMD --type f --hidden --follow --exclude '.git' --exclude '.svn' --exclude 'node_modules'"
  export FZF_DEFAULT_OPTS="--layout=reverse --preview '([[ -f {} ]] && ($_FZF_BAT_CMD --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$_FZF_FD_CMD --type d --hidden --follow --exclude '.git'"

  _fzf_compgen_dir() {
      "$_FZF_FD_CMD" --type d --hidden --follow --exclude ".git" . "$1"
  }
  _fzf_compgen_path() {
      "$_FZF_FD_CMD" --type f --hidden --follow --exclude ".git" . "$1"
  }

fi