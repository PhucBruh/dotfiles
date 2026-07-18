#!/usr/bin/env bash
set -uo pipefail
source "$(cd "$(dirname "$0")" && pwd)/core.sh"

ENTRIES=$(cat <<EOF
Neovim $HOME/.config/nvim 
Tmux $HOME/.config/tmux tmux.conf
Ghostty $HOME/.config/ghostty config
Yazi $HOME/.config/yazi yazi.toml
Starship $HOME/.config --file starship.toml
Zsh $HOME --file .zshrc
Rofi $HOME/.config/rofi --file config.rasi
EOF
)

SELF="$(readlink -f "$0")"

if [ "${1:-}" = "--preview" ]; then
    line="$(grep -m1 "^${2} " <<< "$ENTRIES")"
    [ -z "$line" ] && exit 0
    IFS=' ' read -r _ dir a b <<< "$line"
    if [ "$a" = "--file" ]; then
        printf 'dir: %s\n---\n' "$dir"
        tl::preview::file "$dir/$b"
    else
        tl::preview::tree "$dir"
    fi
    exit 0
fi

items() {
    while IFS=' ' read -r n d a b; do
        if [ "$a" = "--file" ]; then
            printf '%s\t%s\t%s\n' "$n" "$n" "$d/$b"
        else
            printf '%s\t%s\t%s\n' "$n" "$n" "$d"
        fi
    done <<< "$ENTRIES"
}

result="$(items | tl::fzf --border-label ' Dotfiles ' --prompt "> " --with-nth "2" \
    --preview "'$SELF' --preview {1}")"
[ -z "$result" ] && exit 0
line="$result"

name="$(cut -f1 <<< "$line")"
entry="$(grep -m1 "^${name} " <<< "$ENTRIES")"
[ -z "$entry" ] && exit 0

IFS=' ' read -r name dir a b <<< "$entry"
if [ "$a" = "--file" ]; then
    tl::window::open "$name" "$dir" "${EDITOR:-vi}" "$dir/$b"
elif [ -n "$a" ]; then
    tl::window::open "$name" "$dir" "${EDITOR:-vi}" "$dir/$a"
else
    tl::window::open "$name" "$dir" "${EDITOR:-vi}"
fi
