local builtins = require('telescope.builtin');
vim.keymap.set("n", "<leader>ts", builtins.spell_suggest, { noremap = true, silent = true, desc="Spell suggest" })
vim.keymap.set("n", "<leader>tk", builtins.keymaps, { noremap = true, silent = true, desc="Show keymaps" })
vim.keymap.set("n", "<leader>tt", builtins.treesitter, { noremap = true, silent = true, desc="Telescope treesitter" })
vim.keymap.set("n", "<leader>tb", builtins.buffers, { noremap = true, silent = true, desc="Telescope buffers" })
vim.keymap.set("n", "<leader>tg", builtins.live_grep, { noremap = true, silent = true, desc="Telescope buffers" })
vim.keymap.set("n", "<leader><leader>", builtins.builtin, { noremap = true, silent = true, desc="Telescope builtins" })

require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    }
  }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")

