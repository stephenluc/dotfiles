-- Leader keys (must be set before any mappings)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Encoding
opt.encoding = "utf-8"

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true
opt.softtabstop = 0

-- Line numbers (hybrid)
opt.number = true
opt.relativenumber = true

-- Mouse
opt.mouse = "a"

-- Display
opt.showmatch = true
opt.showmode = false
opt.title = true
opt.linebreak = true
opt.scrolloff = 8
opt.termguicolors = true
opt.wildmenu = true
opt.wildmode = "longest:full,full"

-- Search
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Clipboard (macOS)
opt.clipboard = "unnamedplus"

-- Undo / swap
opt.undofile = true
opt.swapfile = false

-- Misc
vim.o.autoread = true
opt.ttimeoutlen = 50
opt.backspace = "indent,eol,start"

-- Restore last edit position when opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      vim.cmd('normal! g`"')
    end
  end,
})
