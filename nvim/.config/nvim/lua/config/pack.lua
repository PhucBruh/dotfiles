-- stylua: ignore start
local gh = function(x) return 'https://github.com/' .. x end
local cb = function(x) return 'https://codeberg.org/' .. x end
-- stylua: ignore end

vim.pack.add({
  -- LSP Native
  { src = gh("neovim/nvim-lspconfig") },

  -- Treesitter
  { src = gh("nvim-treesitter/nvim-treesitter") },

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
  { src = gh("MeanderingProgrammer/render-markdown.nvim") },
  { src = gh("techwizrd/render-latex.nvim") },

  -- Typst
  { src = gh("chomosuke/typst-preview.nvim") },

  -- Git
  { src = gh("lewis6991/gitsigns.nvim") },

  -- Oil
  { src = gh("stevearc/oil.nvim") },

  -- mini.nvim
  { src = gh("nvim-mini/mini.nvim"), version = "stable" },

  -- Editor & UX
  { src = gh("ibhagwan/fzf-lua") },
  { src = cb("andyg/leap.nvim") },
  { src = gh("kylechui/nvim-surround"), version = vim.version.range("4.x") },
  { src = gh("chrisgrieser/nvim-origami") },

  -- UI
  { src = gh("folke/which-key.nvim") },
  { src = gh("scottmckendry/cyberdream.nvim") },
  { src = gh("j-hui/fidget.nvim") },
})
