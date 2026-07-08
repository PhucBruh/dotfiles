# picker.sh — shared framework for tmux fzf-based pickers
# Every picker script sources this file, then calls `picker()`.
#
# Usage:
#   picker 
#     --name    "window"                                        
#     --source  'tmux list-windows -a -F "..."'                 
#     --on-select   handle_select                               
#     [--on-kill    handle_kill]                                 
#     [--on-rename  handle_rename]                               
#     [--header     "custom header"]                             
#     [--preview    "preview command"]                           
#     [--prompt     "> "]                                        
#     [--delimiter  "\t"]                                        
#     [--with-nth   "1"]                                         
#     [--one-shot]           # skip the loop, exit after select
#
# Callback functions receive the selected fzf line as $1.

# --- Configuration ---

FLAG_DIR="${FLAG_DIR:-/tmp}"
PICKER_PROMPT="${PICKER_PROMPT:-> }"

# --- Tmux helpers ---

tmux_cmd() { tmux "$@"; }

tmux_opt() {
  local name="$1" default="$2"
  tmux show-option -gv "$name" 2>/dev/null || echo "$default"
}

# --- User interaction ---

confirm() {
  echo -n "$1 [y/N] "
  local resp
  read -r resp
  [ "$resp" = y ] || [ "$resp" = Y ]
}

prompt() {
  local msg="$1" resp
  echo -n "$msg"
  read -r resp
  echo "$resp"
}

# --- Flag-file helpers (for fzf action dispatch) ---

_flag_file() { echo "${FLAG_DIR}/tmux-flag-$1"; }
_clean_flag() { rm -f "$1"; }

# --- Build fzf arguments from picker options ---

_build_fzf_args() {
  local -n _args=$1
  local header="$2" prompt="$3" preview="$4" delimiter="$5" with_nth="$6"
  local flag_kill="$7" flag_rename="$8"
  local has_kill="$9" has_rename="${10}"

  _args=(--height=100% --ansi)
  [ -n "$header" ]    && _args+=(--header "$header")
  [ -n "$prompt" ]    && _args+=(--prompt "$prompt")
  [ -n "$preview" ]   && _args+=(--preview "$preview")
  [ -n "$delimiter" ] && _args+=(--delimiter "$delimiter")
  [ -n "$with_nth" ]  && _args+=(--with-nth "$with_nth")

  $has_kill   && _args+=(--bind "ctrl-k:execute(echo -n {} > $flag_kill)+accept")
  $has_rename && _args+=(--bind "ctrl-r:execute(echo -n {} > $flag_rename)+accept")
}

# --- Generate a default header from available actions ---

_default_header() {
  local has_kill="$1" has_rename="$2"
  local parts=()
  $has_kill   && parts+=("ctrl-k: kill")
  $has_rename && parts+=("ctrl-r: rename")
  parts+=("Enter: select" "Esc: exit")

  local IFS=" · "
  echo "${parts[*]}"
}

# --- Core picker function ---

picker() {
  local name="" source_cmd="" header="" preview="" prompt="$PICKER_PROMPT"
  local delimiter="" with_nth=""
  local on_select="" on_kill="" on_rename=""
  local one_shot=false

  # Parse arguments
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --name)       name="$2";       shift 2 ;;
      --source)     source_cmd="$2"; shift 2 ;;
      --on-select)  on_select="$2";  shift 2 ;;
      --on-kill)    on_kill="$2";    shift 2 ;;
      --on-rename)  on_rename="$2";  shift 2 ;;
      --header)     header="$2";     shift 2 ;;
      --preview)    preview="$2";    shift 2 ;;
      --prompt)     prompt="$2";     shift 2 ;;
      --delimiter)  delimiter="$2";  shift 2 ;;
      --with-nth)   with_nth="$2";   shift 2 ;;
      --one-shot)   one_shot=true;   shift   ;;
      *) echo "picker: unknown option: $1" >&2; return 1 ;;
    esac
  done

  [ -z "$name" ]       && { echo "picker: --name is required" >&2; return 1; }
  [ -z "$source_cmd" ] && { echo "picker: --source is required" >&2; return 1; }
  [ -z "$on_select" ]  && { echo "picker: --on-select is required" >&2; return 1; }

  local has_kill=false has_rename=false
  [ -n "$on_kill" ]   && has_kill=true
  [ -n "$on_rename" ] && has_rename=true

  # Auto-generate header when not explicitly set
  [ -z "$header" ] && header=$(_default_header "$has_kill" "$has_rename")

  local flag_kill flag_rename
  flag_kill="$(_flag_file "${name}-kill")"
  flag_rename="$(_flag_file "${name}-rename")"

  while true; do
    _clean_flag "$flag_kill"
    _clean_flag "$flag_rename"

    local items
    items=$(eval "$source_cmd") || true
    [ -z "$items" ] && break

    local fzf_args=()
    _build_fzf_args fzf_args \
      "$header" "$prompt" "$preview" "$delimiter" "$with_nth" \
      "$flag_kill" "$flag_rename" \
      "$has_kill" "$has_rename"

    local result
    result=$(echo "$items" | fzf "${fzf_args[@]}")
    [ -z "$result" ] && break

    # Dispatch action
    if [ -f "$flag_kill" ]; then
      _clean_flag "$flag_kill"
      "$on_kill" "$result"
    elif [ -f "$flag_rename" ]; then
      _clean_flag "$flag_rename"
      "$on_rename" "$result"
    else
      "$on_select" "$result"
      break
    fi

    # One-shot pickers exit after any action
    $one_shot && break
  done
}

# --- Convenience: one-shot pick (no loop, no actions) ---

pick_one() {
  local items="$1"; shift
  [ -z "$items" ] && return 1
  echo "$items" | fzf --height=100% --ansi "$@"
}
