#!/usr/bin/env bash
# yazi.sh — open yazi file manager (prefix f → f/F)
#
# Usage: yazi.sh [directory]

set -uo pipefail
source "$(cd "$(dirname "$0")" && pwd)/core.sh"

command -v yazi >/dev/null || { echo "yazi not found" >&2; exit 1; }

dir="${1:-$(tl::current_path)}"
tl::window::open "yazi" "$dir" yazi
