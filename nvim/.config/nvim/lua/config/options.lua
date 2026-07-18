local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true

opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.signcolumn = "yes:1"
opt.foldcolumn = "1"

opt.termguicolors = true
opt.laststatus = 3

opt.statuscolumn = "%s%=%4l %C  "
opt.statusline = "%f %m %= %y │ %l:%c "

opt.fillchars = {
  eob = " ",
  fold = " ",
  foldopen = "",
  foldsep = " ",
  foldinner = " ",
  foldclose = "",

  vert = "│",
  horiz = "─",
}

-- fold
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99

-- indent
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smartindent = true
opt.shiftround = true

-- search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- editing
opt.clipboard = "unnamedplus"
opt.mouse = "a"

opt.swapfile = false
opt.undofile = true

opt.completeopt = {
  "menuone",
  "popup",
  "noinsert",
}

opt.inccommand = "nosplit"

-- window
opt.splitright = true
opt.splitbelow = true
vim.o.winborder = "single"

-- performance
opt.timeoutlen = 300
opt.updatetime = 200

opt.confirm = true
