local rocks_config = {
    rocks_path = vim.env.HOME .. "/.local/share/nvim/rocks",
}

vim.g.rocks_nvim = rocks_config

local luarocks_path = {
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

local luarocks_cpath = {
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
}
package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "*", "*"))

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

vim.keymap.set('n', '<Esc>', '<Cmd>noh<CR>')

vim.keymap.set('n', '<leader>ev', '<Cmd>e $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>sv', '<Cmd>luafile $MYVIMRC<CR>')

vim.keymap.set('n', '<C-t>', ':Term<CR>', { noremap = true })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Options
vim.opt.number=true
vim.opt.relativenumber=true
vim.opt.ttimeoutlen=10

vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true
vim.opt.autoindent=true
vim.opt.colorcolumn = '80'

vim.opt.showmatch=true
vim.opt.spelllang="en,fr"

vim.opt.splitright = true
vim.opt.splitbelow = true

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
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>cc", ":<c-u>norm gcsic]c<cr>", { desc = "Execute cell and go to next cell." })
-- vim.keymap.set("i", "<Enter>", require("blink.cmp").select_and_accept, { desc = "Accept completion suggestion." })
