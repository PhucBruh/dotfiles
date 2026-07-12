-- stylua: ignore start
local gh = function(x) return 'https://github.com/' .. x end
local cb = function(x) return 'https://codeberg.org/' .. x end
-- stylua: ignore end

vim.pack.add({
  -- LSP Native
  { src = gh("neovim/nvim-lspconfig") },

  -- Treesitter
  { src = gh("nvim-treesitter/nvim-treesitter") },

  -- Autocompletion & Snippets
  { src = gh("saghen/blink.lib") },
  { src = gh("Saghen/blink.cmp"), version = vim.version.range("1.x") },
  { src = gh("rafamadriz/friendly-snippets") },

  -- Notes (zk)
  { src = gh("zk-org/zk-nvim"), ft = "markdown" },

  -- Formatting
  { src = gh("stevearc/conform.nvim") },

  -- Rust
  { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("^9"), ft = "rust" },

  -- Notebook
  { src = gh("sheng-tse/jupynvim"), name = "jupynvim", ft = "ipynb" },

  -- Markdown
  { src = gh("YousefHadder/markdown-plus.nvim"), ft = "markdown" },
  { src = gh("MeanderingProgrammer/render-markdown.nvim"), ft = "markdown" },
  { src = gh("techwizrd/render-latex.nvim"), ft = "markdown" },
  { src = gh("3rd/image.nvim"), ft = "markdown" },
  { src = gh("Jacky-Lzx/img-clip.nvim"), ft = "markdown" },

  -- Typst
  { src = gh("chomosuke/typst-preview.nvim"), ft = "typst" },

  -- Git
  { src = gh("lewis6991/gitsigns.nvim") },

  -- mini.nvim
  { src = gh("nvim-mini/mini.nvim"), version = "stable" },

  -- Editor & UX
  { src = gh("ibhagwan/fzf-lua"), keys = { "<leader>f", "<leader>?" } },
  { src = cb("andyg/leap.nvim") },
  { src = gh("kylechui/nvim-surround"), version = vim.version.range("4.x") },
  { src = gh("chrisgrieser/nvim-origami") },
  { src = gh("aserowy/tmux.nvim") },

  -- UI
  { src = gh("folke/which-key.nvim") },
  { src = gh("scottmckendry/cyberdream.nvim") },
})
