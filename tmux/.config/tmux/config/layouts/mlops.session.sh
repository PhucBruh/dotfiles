session_root "${PROJECT_DIR:-$HOME}"

if initialize_session "${SESSION_NAME:-mlops}"; then
  new_window "code"
  new_window "train"
  new_window "monitor"
  select_window "code"
fi
finalize_and_go_to_session
