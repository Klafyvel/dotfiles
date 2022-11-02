local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

return require('packer').startup(function()
  use {
    'wbthomason/packer.nvim',
    config = function()
      vim.cmd([[
      augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerCompile
      augroup end
      ]])
    end
  }

  -- Appearance
  use {
    "EdenEast/nightfox.nvim",
    config = function()
      require('nightfox').init()
      vim.cmd("colorscheme nightfox")
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    after = "nightfox.nvim",
    config = function()
      require('lualine').setup {
        options = {
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        }
      }
    end
  }
  use 'junegunn/goyo.vim'
  --
  -- Misc.
  -- use 'vimwiki/vimwiki'

  use {
    'nvim-neorg/neorg',
    config = function()
      require('neorg').setup {
        load = {
          ['core.defaults'] = {},
          ["core.norg.dirman"] = {
            config = {
              workspaces = {
                journal = "~/notes/journal",
                home = "~/notes/home",
                gtd = "~/notes/gtd",
              }
            }
          },
          ["core.gtd.base"] = {
            config = {
              workspace = "gtd"
            }
          },
          -- ["core.norg.concealer"] = {},
          ["core.norg.journal"] = {
            config = {
              workspace = "journal"
            }
          },
          ["core.norg.qol.toc"] = {},
          ["core.integrations.telescope"] = {}
        }
      }
    end,
    requires = {"nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope"}
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use {
    'jpalardy/vim-slime-ext-plugins',
    requires = 'Klafyvel/vim-slime-ext-wezterm',
    setup = function()
      vim.cmd([[
      nmap <leader>cv <Plug>SlimeConfig
      noremap cs <Plug>SlimeOperator
      noremap <leader>cl <Plug>SlimeLineSend
      ]])
    end
  }
  use {
    'Klafyvel/vim-slime-ext-wezterm',
    setup = function()
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_target_send = "slime_wezterm#send"
      vim.g.slime_target_config = "slime_wezterm#config"
    end
  }
  use {
    'klafyvel/vim-slime-cells',
    -- ft = { 'julia' },
    setup = function()
      vim.g.slime_cell_delimiter = "^\\s*##--"
      vim.cmd([[
      nmap <leader>cc <Plug>SlimeCellsSendAndGoToNext
      nmap <leader>cj <Plug>SlimeCellsNext
      nmap <leader>ck <Plug>SlimeCellsPrev
      imap <C-c> ##--
      ]])
    end
  }

  -- File management
  use {
    -- Ranger in neovim
    'kevinhwang91/rnvimr',
    setup = function()
      vim.cmd([[
      nmap <leader>rr :RnvimrToggle<cr>
      ]])
    end
  }
  --
  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep', 'nvim-telescope/telescope-fzf-native.nvim' },
    config = function()
      local builtins = require('telescope.builtin');
      vim.keymap.set("n", "<leader>tt", builtins.find_files, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>tg", builtins.git_files, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>tc", builtins.git_commits, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>ts", builtins.spell_suggest, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>tk", builtins.keymaps, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader><leader>", builtins.current_buffer_fuzzy_find, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>ty", builtins.treesitter, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>tb", builtins.buffers, { noremap = true, silent = true })
    end
  }

  -- Julia specifics
  use {
    'JuliaEditorSupport/julia-vim',
    -- ft = {'julia'},
    setup = function()
      vim.g.latex_to_unicode_tab = 0
      vim.g.latex_to_unicode_keymap = 1
      vim.g.julia_blocks = 0
    end
  }

  -- Arduino
  use {
    'stevearc/vim-arduino',
    requires = 'Klafyvel/vim-slime-ext-plugins',
    -- ft = {'arduino'},
    config = function()
      vim.g.arduino_use_cli = 1
      vim.g.arduino_serial_cmd = "wezterm serial --baud {baud} {port}"
      vim.g.arduino_auto_baud = 1
      vim.g.slime_bracketed_paste = 0
      vim.cmd([[
      nnoremap <buffer> <leader>am <cmd>ArduinoVerify<CR>
      nnoremap <buffer> <leader>au <cmd>ArduinoUpload<CR>
      nnoremap <buffer> <leader>ad <cmd>ArduinoUploadAndSerial<CR>
      nnoremap <buffer> <leader>ab <cmd>ArduinoChooseBoard<CR>
      nnoremap <buffer> <leader>ap <cmd>ArduinoChooseProgrammer<CR>
      ]])
    end
  }
  --
  -- Language Server Protocol stuffs and other syntax utilities
  -- -- use 'neovim/nvim-lsp'
  -- use "williamboman/mason.nvim"
  -- use "williamboman/mason-lspconfig.nvim"
  use {
    "neovim/nvim-lspconfig",
    opt = true,
    event = "BufReadPre",
    after = { "nvim-cmp", "LuaSnip" },
    config = function()
      require("lsp").setup()
    end,
  }
  use {
    'hrsh7th/nvim-cmp', -- Autocompletion plugin
    after = { 'LuaSnip' },
    -- config = function ()
    --   require('cmp_config').setup()
    -- end,
  }
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use {
    'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
    after = { "nvim-cmp" }
  }
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = 'nvim-treesitter/playground',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "julia", "c", "cpp", "python", "vim", "lua", "norg", "query" },
        highlight = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        playground = {
          enable = false,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        },
      }

    end,
  }

  -- Git
  use 'tpope/vim-fugitive'

  -- -- Am I a vim nerd ?
  -- use 'junegunn/vader.vim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
