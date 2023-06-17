return {
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },

  -- File management
  -- use {
  --   -- Ranger in neovim
  --   'kevinhwang91/rnvimr',
  --   setup = function()
  --     vim.cmd([[
  --     nmap <leader>rr :RnvimrToggle<cr>
  --     ]])
  --   end
  -- }
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  'tpope/vim-fugitive',
  'junegunn/goyo.vim'
}
