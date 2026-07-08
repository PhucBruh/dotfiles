session_root "${PROJECT_DIR:-$HOME}"

if initialize_session "${SESSION_NAME:-dev}"; then
  new_window "code"
  new_window "term"
  select_window "code"
fi
finalize_and_go_to_session
