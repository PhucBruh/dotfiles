session_root "${PROJECT_DIR:-$HOME}"

if initialize_session "${SESSION_NAME:-research}"; then
  new_window "notes"
  new_window "code"
  new_window "logs"
  select_window "notes"
fi
finalize_and_go_to_session
