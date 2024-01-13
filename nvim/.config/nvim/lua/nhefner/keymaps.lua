-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap opts
local opts = { noremap = true, silent = true }
--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- save / quit
keymap("n", "<leader>s", ":w<CR>", opts)
keymap("n", "<leader>ss", ":wq<CR>", opts)

-- Windows
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-j>", "<C-w>k", opts)
keymap("n", "<C-k>", "<C-w>j", opts)
keymap("n", "<A-Up>", ":resize -2<CR>", opts)
keymap("n", "<A-Down>", ":resize +2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize -2<CR>", opts)

-- Markdown Preview
keymap("n", "<C-p>", ":MarkdownPreviewToggle<CR>", opts)

-- Nvim Tree
keymap("n", "<leader>f", ":NvimTreeToggle<CR>", opts)

-- Telescope
local builtin = require('telescope.builtin')
keymap("n", '<leader>ff', builtin.find_files, {})
keymap("n", '<leader>fg', builtin.live_grep, {})
keymap("n", '<leader>fb', builtin.buffers, {})
keymap("n", '<leader>fh', builtin.help_tags, {})

-- Barbar
keymap("n", '<leader>,', '<Cmd>BufferPrevious<CR>', opts)
keymap("n", '<leader>.', '<Cmd>BufferNext<CR>', opts)
keymap("n", '<leader>c', '<Cmd>BufferClose<CR>', opts)
