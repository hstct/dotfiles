local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

-- Fix * (Keep the cursor position, don't move to next match)
map("n", "*", "*N")

-- Visual * and # search
-- Until https://github.com/neovim/neovim/pull/15472 is merged
map("x", "*", 'y/\\V<C-R>"<CR>')
map("x", "#", 'y?\\V<C-R>"<CR>')

-- Fix n and N. Keeping cursor in center
map("n", "n", "nzz")
map("n", "N", "Nzz")

map("n", "<ESC>", "<CMD>noh<CR>")

-- Mimic shell movements
map("i", "<C-E>", "<ESC>A")
map("i", "<C-A>", "<ESC>I")

-- Quickly save the current buffer or all buffers
map("n", "<leader>w", "<CMD>update<CR>")
map("n", "<leader>W", "<CMD>wall<CR>")

-- Quite neovim
map("n", "<C-Q>", "<CMD>q<CR>")

-- leader-o/O inserts blank line below/above
map("n", "<leader>o", "o<ESC>")
map("n", "<leader>O", "O<ESC>")

-- Move to the next/previous buffer
map("n", "<leader>[", "<CMD>bp<CR>")
map("n", "<leader>]", "<CMD>bn<CR>")

-- Move to last buffer
map("n", "''", "<CMD>b#<CR>")

-- Copying the vscode behavior of making tab splits
map("n", "<C-\\>", "<CMD>vsplit<CR>")
map("n", "<A-\\>", "<CMD>split<CR>")

-- Resize window using <Shift> arrow keys
map("n", "<S-Up>", "<CMD>resize +2<CR>")
map("n", "<S-Down>", "<CMD>resize -2<CR>")
map("n", "<S-Left>", "<CMD>vertical resize -2<CR>")
map("n", "<S-Right>", "<CMD>vertical resize +2<CR>")

-- Move line up and down in NORMAL and VISUAL modes
-- Reference<CR> https://vim.fandom.com/wiki/Moving_lines_up_or_down
map("n", "<A-j>", "<CMD>move .+1<CR>==")
map("n", "<A-k>", "<CMD>move .-2<CR>==")
map("x", "<A-j>", ":move '>+1<CR>gv=gv")
map("x", "<A-k>", ":move '<-2<CR>gv=gv")

-- Use operator pending mode to visually select the whole buffer
-- e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
map("o", "A", ":<C-U>normal! mzggVG<CR>`z")
map("x", "A", ":<C-U>normal! ggVG<CR>")

-- Switch buffers
map("n", "<C-Left>", "<CMD>bprevious<CR>")
map("n", "<C-Right>", "<CMD>bnext<CR>")
map("n", "<S-h>", "<CMD>bp<CR>")
map("n", "<S-l>", "<CMD>bn<CR>")
map("n", "<S-x>", "<CMD>bdelete!<CR>")

-- neogit
map("n", "<leader>gg", "<CMD>Neogit kind=split<CR>")
