local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Normal mode
map('n', '<esc><esc>', ':noh<cr><esc>', opts) -- Clear search highlighting

