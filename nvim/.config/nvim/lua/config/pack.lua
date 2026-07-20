-- stylua: ignore start
local gh = function(x) return 'https://github.com/' .. x end
local cb = function(x) return 'https://codeberg.org/' .. x end
-- stylua: ignore end

vim.pack.add({
  -- LSP
  { src = gh("neovim/nvim-lspconfig") },

  -- Dap
  { src = gh("mfussenegger/nvim-dap") },
  { src = gh("igorlfs/nvim-dap-view"), version = vim.version.range("1.*") },

  -- Treesitter
  { src = gh("romus204/tree-sitter-manager.nvim") },

  -- Formatting
  { src = gh("stevearc/conform.nvim") },

  -- Autocompletion & Snippets
  { src = gh("saghen/blink.lib") },
  { src = gh("Saghen/blink.cmp"), version = vim.version.range("1.x") },
  { src = gh("rafamadriz/friendly-snippets") },

  -- Notes (zk)
  { src = gh("zk-org/zk-nvim") },

  -- Image
  { src = gh("3rd/image.nvim") },
  { src = gh("Jacky-Lzx/img-clip.nvim") },

  -- Rust
  { src = gh("mrcjkb/rustaceanvim"), version = vim.version.range("^9") },

  -- Notebook
  { src = gh("sheng-tse/jupynvim"), name = "jupynvim" },

  -- Markdown
  { src = gh("YousefHadder/markdown-plus.nvim") },
  { src = gh("OXY2DEV/markview.nvim") },
  { src = gh("techwizrd/render-latex.nvim") },

  -- Typst
  { src = gh("chomosuke/typst-preview.nvim") },

  -- Oil
  { src = gh("stevearc/oil.nvim") },

  -- mini.nvim
  { src = gh("nvim-mini/mini.nvim"), version = "stable" },

  -- Editor & UX
  { src = gh("ibhagwan/fzf-lua") },
  { src = cb("andyg/leap.nvim") },
  { src = gh("chrisgrieser/nvim-origami") },
  { src = gh("christoomey/vim-tmux-navigator") },

  -- UI
  { src = gh("nvim-lualine/lualine.nvim") },
  { src = gh("folke/which-key.nvim") },
  { src = gh("scottmckendry/cyberdream.nvim") },
  { src = gh("j-hui/fidget.nvim") },
})
