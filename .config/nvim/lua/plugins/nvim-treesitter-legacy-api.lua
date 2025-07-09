require("nvim-treesitter.configs").setup({
    -- ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "julia", "python", "toml", "yaml", "norg" }, 
    highlight = {
        enable = true,
    },
    -- incremental_selection = {
    --   enable = true,
    --   keymaps = {
    --     init_selection = "gnn",
    --     node_incremental = "grn",
    --     scope_incremental = "grc",
    --     node_decremental = "grm",
    --   },
    -- },
    -- -- playground = {
    -- --   enable = false,
    -- --   disable = {},
    -- --   updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
    -- --   persist_queries = false, -- Whether the query persists across vim sessions
    -- --   keybindings = {
    -- --     toggle_query_editor = 'o',
    -- --     toggle_hl_groups = 'i',
    -- --     toggle_injected_languages = 't',
    -- --     toggle_anonymous_nodes = 'a',
    -- --     toggle_language_display = 'I',
    -- --     focus_language = 'f',
    -- --     unfocus_language = 'F',
    -- --     update = 'R',
    -- --     goto_node = '<cr>',
    -- --     show_help = '?',
    -- --   },
    -- -- },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = { query = "@function.outer", desc = "around function" },
          ["if"] = { query = "@function.inner", desc = "in function" },
          ["ac"] = { query = "@code_cell.outer", desc = "around code cell" },
          ["ic"] = { query = "@code_cell.inner", desc = "in code cell" },
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]c"] = {query = "@code_cell.inner", desc = "next code block"},
        },
        goto_previous_start = {
          ["[c"] = {query = "@code_cell.inner", desc = "previous code block"},
        },
      },
    },
    indent = {
      enable = true
    },
})
