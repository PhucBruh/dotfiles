-- stylua: ignore start
local gh = function(x) return 'https://github.com/' .. x end
local cb = function(x) return 'https://codeberg.org/' .. x end
-- stylua: ignore end

vim.pack.add({
  -- LSP Native
  { src = gh("neovim/nvim-lspconfig") },
  { src = gh("mason-org/mason.nvim") },
  { src = gh("WhoIsSethDaniel/mason-tool-installer.nvim") },

  -- Treesitter
  { src = gh("nvim-treesitter/nvim-treesitter") },

  -- Autocompletion & Snippets
  { src = gh("saghen/blink.lib") },
  { src = gh("Saghen/blink.cmp"), version = vim.version.range("1.x") },
  { src = gh("rafamadriz/friendly-snippets") },

  -- Orgmode
  { src = gh("nvim-orgmode/orgmode") },
  { src = gh("chipsenkbeil/org-roam.nvim") },
  { src = gh("akinsho/org-bullets.nvim") },
  { src = gh("danilshvalov/org-modern.nvim") },

  -- Formatting (Format on save)
  { src = gh("stevearc/conform.nvim") },

  -- Notebook
  { src = gh("sheng-tse/jupynvim"), name = "jupynvim" },

  -- Markdown
  { src = gh("YousefHadder/markdown-plus.nvim") },
  { src = gh("MeanderingProgrammer/render-markdown.nvim") },

  -- Git
  { src = gh("lewis6991/gitsigns.nvim") },

  -- mini.nvim
  { src = gh("nvim-mini/mini.nvim"), version = "stable" },

  -- snack.nvim
  { src = gh("folke/snacks.nvim") },

  -- Editor & UX
  { src = gh("ibhagwan/fzf-lua") },
  { src = gh("stevearc/oil.nvim") },
  { src = cb("andyg/leap.nvim") },
  { src = gh("kylechui/nvim-surround"), version = vim.version.range("4.x") },
  { src = gh("chrisgrieser/nvim-origami") },
  { src = gh("aserowy/tmux.nvim") },

  -- UI
  { src = gh("folke/which-key.nvim") },
  { src = gh("scottmckendry/cyberdream.nvim") },
})
