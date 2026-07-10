session_root "${PROJECT_DIR:-$HOME}"

if initialize_session "default"; then
  new_window "main"
  split_v 20
  select_pane 0
fi

finalize_and_go_to_session
