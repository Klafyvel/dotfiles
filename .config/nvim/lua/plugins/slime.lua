return {
  {
    'jpalardy/vim-slime-ext-plugins',
    -- dependencies = 'Klafyvel/vim-slime-ext-wezterm',
    config = function()
      vim.cmd([[
      nmap <leader>cv <Plug>SlimeConfig
      noremap cs <Plug>SlimeOperator
      noremap <leader>cl <Plug>SlimeLineSend
      ]])
    end
  },
  -- {
  --   'Klafyvel/vim-slime-ext-wezterm',
  --   config = function()
  --     vim.g.slime_bracketed_paste = 1
  --     vim.g.slime_target_send = "slime_wezterm#send"
  --     vim.g.slime_target_config = "slime_wezterm#config"
  --   end
  -- },
  {
    'Klafyvel/vim-slime-ext-neovim',
    dependencies = { "jpalardy/vim-slime-ext-plugins" },
    config = function()
      vim.g.slime_target_send = "slime_neovim#send"
      vim.g.slime_target_config = "slime_neovim#config"
      -- allows use of PID rather than internal job_id for config see note below this codeblock
      vim.g.slime_input_pid = 1
    end
  },
  {
    'klafyvel/vim-slime-cells',
    -- ft = { 'julia' },
    config = function()
      vim.g.slime_cell_delimiter = "^\\s*##--"
      vim.cmd([[
      nmap <leader>cc <Plug>SlimeCellsSendAndGoToNext
      nmap <leader>cj <Plug>SlimeCellsNext
      nmap <leader>ck <Plug>SlimeCellsPrev
      imap <C-c> ##--
      ]])
    end
  }
}
