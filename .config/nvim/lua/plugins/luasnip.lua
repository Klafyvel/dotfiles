require("luasnip.loaders.from_vscode").lazy_load()
local ls = require('luasnip')
vim.keymap.set({"i", "s"}, "<Tab>", function() ls.jump( 1) end, {silent = true, desc = "Jump forward in snippet."})
vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true, desc = "Jump backward in snippet."})
ls.setup({
  region_check_event = "InsertEnter",
  delete_check_events = "TextChanged,InsertLeave",
})
