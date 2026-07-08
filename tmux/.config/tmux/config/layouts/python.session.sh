#@needs_dir
session_root "${PROJECT_DIR:-$HOME}"

if initialize_session "${SESSION_NAME:-python}"; then
  cd "$session_root"
  python3 -m venv venv 2>/dev/null
  echo "venv/" > .gitignore
  git init

  new_window "editor"
  run_cmd "nvim"
  new_window "terminal"
  select_window "editor"
fi
finalize_and_go_to_session
