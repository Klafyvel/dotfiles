local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
  use{
    'wbthomason/packer.nvim',
    config = function ()
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
    config=function()
      vim.cmd("colorscheme nightfox")
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt=true},
    after = "nightfox.nvim",
    config=function ()
      require('lualine').setup {
        options = {
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
        }
      }
    end
  }

  -- Misc.
  use 'vimwiki/vimwiki'
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  -- use {
  --   'jpalardy/vim-slime',
  --   config=function ()
  --     vim.g.slime_target = "wezterm"
  --     vim.g.slime_no_mappings = 1
  --     vim.cmd([[
  --     nmap <leader>cv <Plug>SlimeConfig
  --     ]])
  --   end
  -- }
  use {
    'jpalardy/vim-slime-ext-plugins',
    requires = 'Klafyvel/vim-slime-ext-wezterm',
    branch='code-restructure',
    config=function ()
      vim.cmd([[
      nmap <leader>cv <Plug>SlimeConfig
      ]])
    end
  }
  use {
    'Klafyvel/vim-slime-ext-wezterm',
    config=function ()
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_target_send = "sime_wezterm#send"
      vim.g.slime_target_config = "sime_wezterm#config"
    end
  }
  use {
    'klafyvel/vim-slime-cells',
    ft = {'julia'},
    config=function ()
      vim.g.slime_cell_delimiter = "^\\s*##"
      vim.cmd([[
      nmap <leader>cc <Plug>SlimeCellsSendAndGoToNext
      nmap <leader>cj <Plug>SlimeCellsNext
      nmap <leader>ck <Plug>SlimeCellsPrev
      ]])
    end
  }

  -- File management
  use {
    -- Ranger in neovim
    'kevinhwang91/rnvimr',
    config=function ()
      vim.cmd([[
      nmap <leader>rr :RnvimrToggle<cr>
      ]])
    end
  }

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep', 'nvim-telescope/telescope-fzf-native.nvim' },
    config = function()
      local builtins = require('telescope.builtin');
      vim.keymap.set("n", "<leader>tt", builtins.find_files, {noremap=true, silent=true})
      vim.keymap.set("n", "<leader>tg", builtins.git_files, {noremap=true, silent=true})
      vim.keymap.set("n", "<leader>tc", builtins.git_commits, {noremap=true, silent=true})
      vim.keymap.set("n", "<leader>ts", builtins.spell_suggest, {noremap=true, silent=true})
      vim.keymap.set("n", "<leader>tk", builtins.keymaps, {noremap=true, silent=true})
      vim.keymap.set("n", "<leader>tf", builtins.current_buffer_fuzzy_find, {noremap=true, silent=true})
      vim.keymap.set("n", "<leader>ty", builtins.treesitter, {noremap=true, silent=true})
      vim.keymap.set("n", "<leader>tb", builtins.buffers, {noremap=true, silent=true})
    end
  }
  use {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require"telescope".load_extension("frecency")
      vim.keymap.set("n", "<leader><leader>", "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>", {noremap = true, silent = true})
    end,
    requires = {"tami5/sqlite.lua"}
  }

  -- Julia specifics
  use {
    'JuliaEditorSupport/julia-vim',
    -- ft = {'julia'},
    config = function()
      vim.g.latex_to_unicode_tab = 0
      vim.g.latex_to_unicode_keymap = 1
    end
  }

  -- Arduino
  use {
    'stevearc/vim-arduino',
    requires = 'Klafyvel/vim-slime-ext-plugins',
    -- ft = {'arduino'},
    config = function()
      vim.g.arduino_use_cli = 1
      vim.g.arduino_use_slime = 1
      vim.cmd([[
      nnoremap <buffer> <leader>am <cmd>ArduinoVerify<CR>
      nnoremap <buffer> <leader>au <cmd>ArduinoUpload<CR>
      nnoremap <buffer> <leader>ad <cmd>ArduinoUploadAndSerial<CR>
      nnoremap <buffer> <leader>ab <cmd>ArduinoChooseBoard<CR>
      nnoremap <buffer> <leader>ap <cmd>ArduinoChooseProgrammer<CR>
      ]])
      -- vim.g.slime_target = "slime_wezterm"
      -- vim.g.slime_default_config = {socket_name="default", target_pane="0"}
      -- vim.g.slime_dont_ask_default = 1
      -- vim.g.slime_bracketed_paste = 1
    end
  }

  -- Language Server Protocol stuffs and other syntax utilities
  -- use 'neovim/nvim-lsp'
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use {
    "neovim/nvim-lspconfig",
    opt = true,
    event = "BufReadPre",
    after = { "mason.nvim", "mason-lspconfig.nvim" },
    config = function()
      require("lsp").setup()
    end,
  }
  -- TODO: setup autocompletion an snippets
  -- use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  -- use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  -- use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  -- use 'L3MON4D3/LuaSnip' -- Snippets plugin

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() 
      require('nvim-treesitter.install').update({ with_sync = true })({"julia", "c", "cpp", "python", "vim", "lua"}) 

    end,
  }

  -- Git
  use 'tpope/vim-fugitive'


  if packer_bootstrap then
    require('packer').sync()
  end
end)