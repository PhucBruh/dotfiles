session_root "${PROJECT_DIR:-$HOME}"

if initialize_session "monitor"; then
  new_window "btop"
  run_cmd "btop"

  new_window "disk"
  run_cmd "df -h"

  new_window "docker"
  run_cmd "docker ps"

  select_window 0
fi

finalize_and_go_to_session
