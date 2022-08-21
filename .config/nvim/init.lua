require "plugins"
-- Mappings
vim.g.mapleader = " "

vim.keymap.set('', '<up>', '<nop>')
vim.keymap.set('', '<down>', '<nop>')
vim.keymap.set('', '<left>', '<nop>')
vim.keymap.set('', '<right>', '<nop>')

vim.keymap.set('n', '<C-k>', '<Cmd>resize +2<CR>')
vim.keymap.set('n', '<C-j>', '<Cmd>resize -2<CR>')
vim.keymap.set('n', '<C-h>', '<Cmd>vertical resize -2<CR>')
vim.keymap.set('n', '<C-l>', '<Cmd>vertical resize +2<CR>')

vim.keymap.set({'v', 'n'}, 'J', '10j')
vim.keymap.set({'v', 'n'}, 'K', '10k')
vim.keymap.set({'v', 'n'}, 'H', '10h')
vim.keymap.set({'v', 'n'}, 'L', '10l')

vim.keymap.set('n', '<leader><space>', '<Cmd>noh<CR>')

vim.keymap.set('n', '<leader>ev', '<Cmd>vsplit $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>sv', '<Cmd>luafile $MYVIMRC<CR>')

vim.keymap.set('n', '<C-t>', ':Term<CR>', { noremap = true })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Options
vim.opt.number=true
vim.opt.relativenumber=true
vim.opt.ttimeoutlen=10

vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.expandtab=true
vim.opt.autoindent=true
vim.opt.colorcolumn = '80'

vim.opt.showmatch=true
vim.opt.spelllang="en,fr"

vim.opt.splitbelow = true
vim.opt.splitright = true

-- AutoCmd
local autocmd = vim.api.nvim_create_autocmd
autocmd('CmdlineEnter', {
  command = 'command! Term :botright vsplit term://$SHELL'
})
autocmd('TermOpen', {
  command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})
autocmd('TermOpen', {
  pattern = '*',
  command = 'startinsert'
})
autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert'
})
autocmd({'BufNewFile','BufRead'}, {
  pattern = '*.jl',
  command = 'set filetype=julia'
})
autocmd('InsertEnter', {
  callback = function()
    vim.api.nvim_command('normal! zz')
  end
})
