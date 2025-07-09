vim.print("hello")
require("blink.cmp").setup {
    keymap = {preset = 'super-tab'},
    sources = {
        default = {'lsp', 'path', 'snippets', 'buffer', 'latex'},
        -- per_filetype = {
        --     -- optionally inherit from the `default` sources
        --     julia = { inherit_defaults = true, 'latex' },
        -- },
        providers = {
            -- default = {"latex"},
            -- create provider
            latex = {
                name = "Latex",
                module = "blink-cmp-latex",
            },
        }
    }
}

