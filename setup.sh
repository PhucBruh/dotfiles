#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

for dir in */; do
  dir="${dir%/}"
  case "$dir" in
    install*|.git) continue ;;
  esac
  stow -R "$dir" 2>/dev/null && echo "  ✔ $dir" || echo "  ✖ $dir"
done

echo "Done. Restart your shell: exec zsh"
