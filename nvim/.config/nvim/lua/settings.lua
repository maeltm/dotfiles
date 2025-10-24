vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.clipboard = 'unnamedplus'
vim.opt.encoding = 'utf-8'
vim.opt.colorcolumn = "80"
vim.opt.list = true
vim.opt.laststatus = 3
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.completeopt = {"menuone", "noselect"}

vim.g.mapleader = ","
vim.api.nvim_set_keymap('', '\\', ',', { noremap = true, silent = true })

vim.cmd [[
  syntax on
  set noimd
  autocmd BufNewFile,BufRead */.ssh/config.d/* set filetype=sshconfig
]]

vim.api.nvim_create_user_command("DisableFormat", function()
  vim.api.nvim_clear_autocmds({
    event = "BufWritePre",
    buffer = 0,
  })
  print("🛑 Format disabled for current buffer.")
end, {})
