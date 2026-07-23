# Neovim Config

- Minimal and clean Neovim configuration powered by native package management.

## Philosophy

- **Native-First**: Built on Neovim 0.12's native `vim.pack` and `vim.lsp.config`. No third-party managers.
- **Minimalist**: Direct control over plugins without bloated abstractions.

## Plugins

- **LSP & Completion**: `nvim-lspconfig`, `blink.cmp`, `conform.nvim`
- **Treesitter**: `nvim-treesitter`
- **Editor**: `mini.nvim` (indentscope, comment, pairs, files, icons, statusline), `leap.nvim`, `nvim-surround`, `nvim-origami`, `oil.nvim`, `fzf-lua`
- **UI**: `cyberdream.nvim`, `which-key.nvim`, `gitsigns.nvim` 
- **Markdown**: `markdown-plus.nvim`, `render-markdown.nvim`, `render-latex.nvim`
- **Rust**: `rustaceanvim`
- **Typst**: `typst-preview.nvim`
- **Notes**: `zk-nvim`
- **Tools**: `jupynvim`, `image.nvim`, `img-clip.nvim`, `tmux.nvim`

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


$$
\operatorname{MultiHead}(Q,K,V) =
\operatorname{Concat}
(
head_1,\ldots,head_h
)
W^O
$$

