# tmux config

Minimal, modular tmux configuration with fzf-powered pickers and project layouts.

## Structure

```
tmux.conf          →     entry point (sources config/*.conf)
config/
  options.conf     →     general settings (prefix, mouse, history, etc.)
  theme.conf       →     status bar, colors, borders
  bindings.conf    →     key bindings + launcher menu
  plugins.conf     →     TPM plugins (resurrect, continuum, tmuxifier, etc.)
  entries.sh       →     dotfiles picker entries (name, path, file)
  layouts/         →     tmuxifier session layouts (*.session.sh)
scripts/
  lib/picker.sh    →     shared fzf picker framework
  window.sh        →     switch / kill / rename windows
  session.sh       →     switch / kill / rename sessions
  project.sh       →     load a tmuxifier layout (with optional dir picker)
  dotfiles.sh      →     open config files in editor
  open-app.sh      →     launch a TUI app in a temp window (auto-closes on leave)
```

## Prefix

Default prefix is `C-a` (unbinds `C-b`).

## Key bindings

| Key | Action |
|-----|--------|
| `prefix + r` | Reload tmux config |
| `prefix + c` | New window (same dir) |
| `prefix + -` | Horizontal split (same dir) |
| `prefix + v` | Vertical split (same dir) |
| `M-1..M-3` | Select window 1-3 |
| `M-h/j/k/l` | Select pane left/down/up/right |
| `M-H/J/K/L` | Resize pane by 2 |
| `prefix + f` | Launcher menu |

*All window/plane operations preserve the current working directory.*

### Launcher menu (`prefix + f`)

| Item | Key | Action |
|------|-----|--------|
| Windows | `i` | Fzf picker — switch/kill/rename windows |
| Sessions | `w` | Fzf picker — switch/kill/rename sessions |
| Layouts | `l` | Load a tmuxifier session layout |
| Dotfiles | `c` | Pick a config to edit (see entries.sh) |
| Yazi | `f` | Open yazi in a temp window |
| Yazi ~ | `F` | Open yazi in $HOME |
| Lazygit | `g` | Open lazygit in a temp window |

### Picker controls (Windows / Sessions)

| Key | Action |
|-----|--------|
| `Enter` | Select |
| `ctrl-k` | Kill |
| `ctrl-r` | Rename |

### Vim navigation

`M-h/j/k/l` for pane navigation (integrates with vim-tmux-navigator).

## Session layouts

Layouts live in `config/layouts/`. A layout is a tmuxifier session script:

```sh
#@needs_dir              # optional: prompts for a project directory
session_root "$PROJECT_DIR"

if initialize_session "$SESSION_NAME"; then
  new_window "editor"
  run_cmd "nvim"
  new_window "terminal"
  select_window "editor"
fi
finalize_and_go_to_session
```

Built-in layouts: `default`, `golang`, `python`, `rust`, `mlops`, `research`.

Layouts tagged with `#@needs_dir` prompt for a project directory via fzf before loading.

## Dotfiles picker

Edit `config/entries.sh` to add/remove entries:

```sh
entries=(
  "Nvim     ~/.config/nvim"
  "tmux     ~/.config/tmux    tmux.conf"
  "Zsh      ~                 .zshrc"
)
```

Format: `"Label<TAB>path<TAB>file"` (tab-separated). `file` is optional — if omitted, opens the directory in the editor.

## Plugins

Managed by TPM (`prefix + I` to install). Listed in `config/plugins.conf`:

- **tmux-resurrect** / **tmux-continuum** — automatic session save/restore (every 15 min)
- **vim-tmux-navigator** — seamless vim/tmux pane navigation
- **tmuxifier** — session/window layouts

## Customization

- Colors: edit `@c_*` options in `config/theme.conf`
- App launcher size: set `@launcher-picker-width`, `@launcher-app-height`, etc. in `config/options.conf`
- Default editor: set `@launcher-editor` (default `nvim`)
