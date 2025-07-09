vim.bo.formatprg = "runic"
vim.treesitter.start()

vim.lsp.enable({"julials"})

-- Hacking into nvim-lspconfig to run JETLS.jl

-- local configs = require('lspconfig.configs')
-- local util = require 'lspconfig.util'
--
-- local jetlslocation = "~/storage/dev/JETLS.jl/"
--
-- local root_files = { 'Project.toml', 'JuliaProject.toml' }
--
-- local cmd = {
--   'julia',
--   '--startup-file=no',
--   '--history-file=no',
--   '--project=' .. jetlslocation,
--   '-e',
--   [[
--   @info "Loading JETLS..."
--   using JETLS
--   @info "Starting server..."
--   runserver(stdin, stdout)
--   ]]
-- }
--
-- configs['juliajetls'] = {
--   default_config = {
--     cmd = cmd,
--     filetypes = { 'julia' },
--     root_dir = function(fname)
--       return util.root_pattern(unpack(root_files))(fname)
--         or vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
--     end,
--     single_file_support = true,
--   },
--   docs = {
--     description = [[
--     A simple configuration to use the [JETLS.jl](https://github.com/aviatesk/JETLS.jl) language server in NeoVim.
--     ]],
--   },
-- }
--
-- require'lspconfig'.juliajetls.setup({})
