local words = {}
for word in io.open(vim.fn.stdpath("config") .. "/spell/en.utf-8.add", "r"):lines() do
	table.insert(words, word)
end

local servers = {
  pyright={},
  lua_ls={},
  vimls={},
  arduino_language_server={
    cmd = {
      "arduino-language-server",
      "-cli-config", "~/.arduino15/arduino-cli.yaml",
      "-fqbn", "arduino:avr:uno",
      "-cli", "arduino-cli",
      "-clangd", "clangd"
    }
  },
  clangd={},
  julials={
    on_new_config = function(new_config, _)
      local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
      if require'lspconfig'.util.path.is_file(julia) then
        new_config.cmd[1] = julia
      end
    end
  },
  ltex={
    filetypes={ "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "norg" },
    additionalRules = {
      -- To be downloaded here: https://languagetool.org/download/ngram-data/
      languageModel = '~/ngrams/',
    },
    dictionary = {
      ["en-US"] = words,
    },
  }
}

local opts = { noremap=true, silent=true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function setup_keymaps(client, bufnr)
  vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<leader>dN', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>D', vim.diagnostic.setloclist, opts)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>lwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>lD', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>lrn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>lca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>lf',function() vim.lsp.buf.format { async = true } end, bufopts)
end

local function on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Configure key mappings
  setup_keymaps(client, bufnr)
end

-- local opts = { noremap=true, silent=true }

function setup()
  -- require("mason").setup()
  -- require("mason-lspconfig").setup({
    --   automatic_installation = true
    -- })
    -- Add additional capabilities supported by nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    for server, serveropts in pairs(servers) do
      local opts = {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        },
        capabilities = capabilities,
      }
      for k,v in pairs(serveropts) do
        opts[k] = v
      end
      require('lspconfig')[server].setup(opts)
    end
    local luasnip = require 'luasnip'
    local cmp = require 'cmp'
    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },
    }
  end

  return {
    {
      "neovim/nvim-lspconfig",
      lazy = true,
      event = "BufReadPre",
      -- after = { "nvim-cmp", "LuaSnip" },
      config = setup,
    },
    {
      'hrsh7th/nvim-cmp', -- Autocompletion plugin
      -- after = { 'LuaSnip' },
      -- config = function ()
        --   require('cmp_config').setup()
        -- end,
      },
      'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
      {
        'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
        -- after = { "nvim-cmp" }
      },
      {
        'L3MON4D3/LuaSnip', -- Snippets plugin
        config = function ()
          require("luasnip").config.set_config({ -- Setting LuaSnip config

          -- Enable autotriggered snippets
          enable_autosnippets = true,

          -- Use Tab (or some other key if you prefer) to trigger visual selection
          store_selection_keys = "<Tab>",
          update_events = 'TextChanged,TextChangedI'
        })
      end
    }
  }
