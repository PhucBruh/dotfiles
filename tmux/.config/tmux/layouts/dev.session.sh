session_root "${PROJECT_DIR:-$HOME}"

if initialize_session "dev"; then
  new_window "code"
  run_cmd "nvim"
  split_v 20
  run_cmd "ls"

  new_window "shell"

  select_window 0
fi

finalize_and_go_to_session
