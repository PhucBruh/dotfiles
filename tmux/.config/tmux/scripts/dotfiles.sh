#!/usr/bin/env bash
set -uo pipefail
source "$(cd "$(dirname "$0")" && pwd)/core.sh"

ENTRIES=$(cat <<EOF
Neovim	$HOME/dotfiles/nvim/.config/nvim	init.lua
Tmux	$HOME/dotfiles/tmux/.config/tmux	tmux.conf
Ghostty	$HOME/dotfiles/ghostty/.config/ghostty	config
Yazi	$HOME/dotfiles/yazi/.config/yazi	yazi.toml
Starship	$HOME/dotfiles/starship/.config	starship.toml
Zsh	$HOME	--file	.zshrc
EOF
)

SELF="$(readlink -f "$0")"

if [ "${1:-}" = "--preview" ]; then
    line="$(grep -m1 "^${2}"$'\t' <<< "$ENTRIES")"
    [ -z "$line" ] && exit 0
    IFS=$'\t' read -r _ dir a b <<< "$line"
    if [ "$a" = "--file" ]; then
        printf 'dir: %s\n---\n' "$dir"
        tl::preview::file "$dir/$b"
    else
        tl::preview::tree "$dir"
    fi
    exit 0
fi

items() {
    while IFS=$'\t' read -r n d a b; do
        if [ "$a" = "--file" ]; then
            printf '%s\t%s\t%s\n' "$n" "$n" "$d/$b"
        else
            printf '%s\t%s\t%s\n' "$n" "$n" "$d"
        fi
    done <<< "$ENTRIES"
}

result="$(items | tl::fzf --border-label ' Dotfiles ' --prompt "Dotfiles > " --with-nth "2" \
    --preview "'$SELF' --preview {1}")"
[ -z "$result" ] && exit 0
line="$result"

name="$(cut -f1 <<< "$line")"
entry="$(grep -m1 "^${name}"$'\t' <<< "$ENTRIES")"
[ -z "$entry" ] && exit 0

IFS=$'\t' read -r name dir a b <<< "$entry"
if [ "$a" = "--file" ]; then
    tl::window::open "$name" "$dir" "${EDITOR:-vi}" "$dir/$b"
elif [ -n "$a" ]; then
    tl::window::open "$name" "$dir" "${EDITOR:-vi}" "$dir/$a"
else
    tl::window::open "$name" "$dir" "${EDITOR:-vi}"
fi
