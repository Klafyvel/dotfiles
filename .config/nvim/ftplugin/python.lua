vim.treesitter.start()
-- vim.lsp.enable({"pyright"})
vim.bo.formatprg = "ruff format -"
vim.lsp.enable('ruff')
