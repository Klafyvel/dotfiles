local builtins = require('telescope.builtin');
vim.keymap.set("n", "<leader>ts", builtins.spell_suggest, { noremap = true, silent = true, desc="Spell suggest" })
vim.keymap.set("n", "<leader>tk", builtins.keymaps, { noremap = true, silent = true, desc="Show keymaps" })
vim.keymap.set("n", "<leader>tt", builtins.treesitter, { noremap = true, silent = true, desc="Telescope treesitter" })
vim.keymap.set("n", "<leader>tb", builtins.buffers, { noremap = true, silent = true, desc="Telescope buffers" })
vim.keymap.set("n", "<leader><leader>", builtins.builtin, { noremap = true, silent = true, desc="Telescope builtins" })

