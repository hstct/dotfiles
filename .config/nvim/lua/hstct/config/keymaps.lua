local u = require("hstct.util.functions")

-- Fix * (keep the cursor position, don't move to next match)
u.map("n", "*", "*N")

-- Visual * and # search
-- Until https://github.com/neovim/neovim/pull/15472 is merged
u.map("x", "*", 'y/\\V<C-R>"<CR>')
u.map("x", "#", 'y?\\V<C-R>"<CR>')

-- Fix n and N. Keeping cursor in center
u.map("n", "n", "nzz")
u.map("n", "N", "Nzz")

-- Remove highlight
u.map("n", "<ESC>", "<CMD>noh<CR>", { desc = "remove highlight" })

-- Mimic shell movements
u.map("i", "<C-E>", "<C-o>$", { desc = "insert: go to line end" })
u.map("i", "<C-A>", "<C-o>^", { desc = "insert: go to line beginning" })

-- Copying the vscode behavior of making tab splits
u.map("n", "<C-\\>", "<CMD>vsplit<CR>", { desc = "tabs: split vertical" })
u.map("n", "<A-\\>", "<CMD>split<CR>", { desc = "tabs: split horizontal" })

-- Resize window using <Shift> arrow keys
u.map("n", "<S-Up>", "<CMD>resize +2<CR>", { desc = "resize window: grow horizontal" })
u.map("n", "<S-Down>", "<CMD>resize -2<CR>", { desc = "resize window: shrink horizontal" })
u.map("n", "<S-Left>", "<CMD>vertical resize -2<CR>", { desc = "resize window: shrink vertical" })
u.map("n", "<S-Right>", "<CMD>vertical resize +2<CR>", { desc = "resize window: grow vertical" })

-- Move line up and down in NORMAL and VISUAL modes
-- Reference<CR> https://vim.fandom.com/wiki/Moving_lines_up_or_down
u.map("n", "<A-j>", "<CMD>move .+1<CR>==", { desc = "line: move up" })
u.map("n", "<A-k>", "<CMD>move .-2<CR>==", { desc = "line: move down" })
u.map("x", "<A-j>", ":move '>+1<CR>gv=gv", { desc = "line: move up" })
u.map("x", "<A-k>", ":move '<-2<CR>gv=gv", { desc = "line: move down" })

-- Use operator pending mode to visually select the whole buffer
-- e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
u.map("o", "A", ":<C-U>normal! mzggVG<CR>`z", { desc = "textobject: whole file" })
u.map("x", "A", ":<C-U>normal! ggVG<CR>", { desc = "textobject: whole file" })

-- buffers
u.map("n", "<S-h>", "<CMD>bp<CR>", { desc = "buffers: move previous" })
u.map("n", "<S-l>", "<CMD>bn<CR>", { desc = "buffers: move next" })
u.map("n", "<S-x>", "<CMD>bdelete!<CR>", { desc = "buffers: delete" })
u.map("n", "''", "<CMD>b#<CR>", { desc = "buffers: move to last" })
u.map("n", "<leader>w", "<CMD>update<CR>", { desc = "buffers: save" })
u.map("n", "<leader>W", "<CMD>wall<CR>", { desc = "buffers: save all" })
