#!/usr/bin/env bash
# apps/yazi.sh [directory]
#
# Opens yazi in a managed window. Auto-closes on focus-out.
# Pass a directory argument (e.g. ~) or defaults to current pane's cwd.
set -uo pipefail
source "$(cd "$(dirname "$0")" && pwd)/core.sh"

command -v yazi >/dev/null || { echo "yazi not found" >&2; exit 1; }

dir="${1:-$(tl::current_path)}"
tl::window::open "yazi" "$dir" yazi
