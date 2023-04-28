local g = vim.g
local o = vim.o

o.termguicolors = true

o.timeoutlen = 500
o.updatetime = 200

o.jumpoptions = "view"

-- Stable buffer content on window open/close events.
o.splitkeep = "screen"

o.scrolloff = 8

o.listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"

o.number = true
o.numberwidth = 5
o.relativenumber = true
o.signcolumn = "yes:2"
o.cursorline = true

o.expandtab = true
o.cindent = true
o.wrap = true
o.textwidth = 300
o.tabstop = 4
o.shiftwidth = 0
o.softtabstop = -1

o.clipboard = "unnamedplus"

o.ignorecase = true
o.smartcase = true

o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false

o.history = 50

o.splitright = true
o.splitbelow = true

o.showmode = false

g.mapleader = " "
g.maplocalleader = " "

g.python3_host_prog = "/sbin/python3"
