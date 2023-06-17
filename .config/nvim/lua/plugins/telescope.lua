return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep', 'nvim-telescope/telescope-fzf-native.nvim' },
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
}
