# prefix f — Launcher Menu

| Key | Label | Action | Backend |
|-----|-------|--------|---------|
| `i` | Windows | tmux-sessionx in **window mode**: list `session:index name` across all sessions. Select → switch to that window. `ctrl-w` toggles window/session view. Preview shows pane content. | `tmux-sessionx` |
| `w` | Sessions | tmux-sessionx in **session mode**: list all sessions. Select → switch, `ctrl-k` kill, `ctrl-r` rename, `ctrl-t` tree view. Preview shows pane content. | `tmux-sessionx` |
| `l` | Layouts | List tmuxifier layouts from `config/layouts/`. Select → load session layout. Layouts with `#@needs_dir` prompt for a project directory first. | `project.sh` + tmuxifier |
| `c` | Dotfiles | List entries from `config/entries.sh`. Select → open file in `$EDITOR` (nvim) in a new window. | `dotfiles.sh` |
| `f` | Yazi | Open yazi in popup at `#{pane_current_path}`. | `open-app.sh` |
| `F` | Yazi ~ | Open yazi in popup at `$HOME`. | `open-app.sh` |
| `g` | Lazygit | Open lazygit in popup at `#{pane_current_path}`. | `open-app.sh` |

## Dimensions

Controlled by tmux options:
- `@launcher-picker-width` (default: `50%`)
- `@launcher-picker-height` (default: `40%`)
- `@launcher-app-width` (default: `90%`)
- `@launcher-app-height` (default: `90%`)
- `@launcher-editor` (default: `nvim`)
