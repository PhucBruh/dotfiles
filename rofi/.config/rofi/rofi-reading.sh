#!/usr/bin/env bash
#
# rofi-reading: rofi launcher for reading files (inbox/papers/books tabs)
# Run without arguments to launch rofi.

READING_DIR=~/Documents/reading

# Command per extension. Supports placeholders:
#   {url}  -> file:// URI  (use this for browsers, e.g. zen-browser)
#   {file} -> raw filesystem path
#   (no placeholder) -> path is appended as the last argument, quoted
declare -A VIEWERS=(
  [pdf]="okular"
  [epub]="ebook-viewer"
  [djvu]="zen"
  [mobi]="ebook-viewer"
  [cbz]="zen"
)

mode="${1:-}"

if [[ -z "$mode" ]]; then
  SELF="$(readlink -f "$0")"
  exec rofi -modi "inbox:$SELF inbox,papers:$SELF papers,books:$SELF books" -show inbox
fi

case "$mode" in
  inbox)  base="$READING_DIR/inbox" ;;
  papers) base="$READING_DIR/papers" ;;
  books)  base="$READING_DIR/books" ;;
  *) exit 0 ;;
esac

open_file() {
  local file="$1"
  local ext="${file##*.}"
  ext="${ext,,}"
  local cmd="${VIEWERS[$ext]:-}"
  [[ -z "$cmd" ]] && cmd="xdg-open {file}"

  local url="file://$file"

  if [[ "$cmd" == *"{url}"* ]]; then
    cmd="${cmd//\{url\}/\"$url\"}"
    setsid bash -c "$cmd" >/dev/null 2>&1 &
  elif [[ "$cmd" == *"{file}"* ]]; then
    cmd="${cmd//\{file\}/\"$file\"}"
    setsid bash -c "$cmd" >/dev/null 2>&1 &
  else
    setsid bash -c "$cmd \"\$1\"" _ "$file" >/dev/null 2>&1 &
  fi
  disown
  exit 0
}

# ROFI_RETV=1: user selected an entry -> ROFI_INFO has the full path
if [[ "${ROFI_RETV:-0}" == "1" ]]; then
  [[ -n "${ROFI_INFO:-}" ]] && open_file "$ROFI_INFO"
  exit 0
fi

[[ -d "$base" ]] || exit 0

ext_pattern=()
for ext in "${!VIEWERS[@]}"; do
  ext_pattern+=(-iname "*.${ext}" -o)
done
unset 'ext_pattern[${#ext_pattern[@]}-1]'

# Write to a temp file instead of a bash variable: command substitution
# strips NUL bytes, which breaks the hidden "info" (full path) field.
tmpfile="$(mktemp)"
find "$base" -type f \( "${ext_pattern[@]}" \) 2>/dev/null | while IFS= read -r f; do
  rel="${f#"$base"/}"
  dir="$(dirname "$rel")"
  fname="$(basename "$rel")"
  if [[ "$dir" == "." ]]; then
    label="$fname"
  else
    label="[$dir] $fname"
  fi
  printf '%s\x00info\x1f%s\n' "$label" "$f"
done | sort > "$tmpfile"

cat "$tmpfile"
rm -f "$tmpfile"
