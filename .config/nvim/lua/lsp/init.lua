local M = {}

local servers = {
'pyright',
'sumneko_lua',
'vimls',
'arduino_language_server',
'clangd',
'julials'
}

local function on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Configure key mappings
  require("lsp.keymaps").setup(client, bufnr)
end

local opts = {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
}
-- local opts = { noremap=true, silent=true }

function M.setup()
  require("mason").setup()
  require("mason-lspconfig").setup({
    automatic_installation = true
  })
  for i,server in ipairs(servers) do
    require'lspconfig'[server].setup(opts)
  end
end

return M
