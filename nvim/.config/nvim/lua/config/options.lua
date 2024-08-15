local opt = vim.opt

-- Left column and similar settings
opt.number = true -- display line numbers
opt.relativenumber = true -- display relative line numbers
opt.wrap = false -- display lines as single line
opt.scrolloff = 10 -- number of lines to keep above/below cursor
opt.sidescrolloff = 8 -- number of columns to keep to the left/right of cursor
vim.diagnostic.config({ signs = false })

-- Tab spacing/behavior
opt.expandtab = true -- convert tabs to spaces
opt.shiftwidth = 2 -- number of spaces inserted for each indentation level
opt.tabstop = 2 -- number of spaces inserted for tab character
opt.softtabstop = 2 -- number of spaces inserted for <Tab> key
opt.smartindent = true -- enable smart indentation
opt.breakindent = true -- enable line breaking indentation

-- General Behaviors
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
opt.backup = false -- disable backup file creation
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)
opt.conceallevel = 0 -- so that `` is visible in markdown files
opt.mouse = "a" -- enable mouse support
opt.showmode = false -- hide mode display
opt.splitbelow = true -- force horizontal splits below current window
opt.splitright = true -- force vertical splits right of current window
opt.termguicolors = true -- enable term GUI colors
opt.timeoutlen = 1000 -- set timeout for mapped sequences
opt.undofile = true -- enable persistent undo
opt.updatetime = 100 -- set faster completion
opt.writebackup = false -- prevent editing of files being edited elsewhere
opt.cursorline = true -- highlight current line

-- Searching Behaviors
opt.hlsearch = true -- highlight all matches in search
opt.ignorecase = true -- ignore case in search
opt.smartcase = true -- match case if explicitly stated
