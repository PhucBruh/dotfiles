# Neovim Config

Minimal and clean Neovim configuration powered by native package management.

## Philosophy (`vim.pack`)

- **Native-First**: Built entirely on Neovim 0.12's native package manager (`vim.pack`). No third-party managers (`lazy.nvim`, `packer`).
- **Minimalist**: Direct control over plugins and setup without bloated abstractions.

## Plugins

- **LSP & Formatting**: `nvim-lspconfig`, `mason.nvim`, `blink.cmp`, `conform.nvim`.
- **Treesitter & UX**: `nvim-treesitter`, `fzf-lua`, `oil.nvim`, `leap.nvim`, `noice.nvim`, `which-key.nvim`.
- **Tools**: `jupynvim`, `leetcode.nvim`, `render-markdown.nvim`.

## Keymaps

> Leader key is `Space`.

### Global

| Keymap | Description |
| :--- | :--- |
| `<leader>w` | Save file |
| `<leader>q` | Quit window |
| `<leader>Q` | Exit Neovim |
| `<leader>c` | Close buffer |
| `<leader>C` | Force close buffer |
| `<leader>?` | Show buffer keymaps |

### Search (Fzf)

| Keymap | Description |
| :--- | :--- |
| `<leader>fi` | Find files |
| `<leader>fj` | Search buffers |
| `<leader>fg` | Live grep |
| `<leader>fb` | Grep current buffer |
| `<leader>fs` | Document symbols |
| `<leader>fr` | LSP references |
| `<leader>fk` | Show keymaps |
| `<leader>fc` | Search Neovim config |

### LSP & Navigation

| Keymap | Description |
| :--- | :--- |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `grr` | Find references |
| `gri` | Go to implementation |
| `grt` | Go to type definition |
| `K` | LSP Hover doc |
| `-` | Open parent dir (Oil) |
| `s` / `S` | Jump forward / backward (Leap) |
| `zR` / `zM` | Open / close folds (UFO) |
