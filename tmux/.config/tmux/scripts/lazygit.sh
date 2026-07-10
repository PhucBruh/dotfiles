#!/usr/bin/env bash
# apps/lazygit.sh
#
# Opens lazygit in a managed window. Auto-closes on focus-out.
set -uo pipefail
source "$(cd "$(dirname "$0")" && pwd)/core.sh"

command -v lazygit >/dev/null || { echo "lazygit not found" >&2; exit 1; }

tl::window::open "lazygit" "$(tl::current_path)" lazygit
