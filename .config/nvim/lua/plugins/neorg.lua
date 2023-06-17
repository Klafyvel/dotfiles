-- Neorg-specific stuff.
return {
  {
    'nvim-neorg/neorg',
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
        },
      }
    end,
  },
    -- config = function()
    --   require('neorg').setup {
    --     load = {
    --       ['core.defaults'] = {},
    --       ["core.norg.dirman"] = {
    --         config = {
    --           workspaces = {
    --             journal = "~/notes/journal",
    --             home = "~/notes/home",
    --             gtd = "~/notes/gtd",
    --             zettel = "~/notes/zettel",
    --           }
    --         }
    --       },
    --       -- ["core.gtd.base"] = {
    --       --   config = {
    --       --     workspace = "gtd"
    --       --   }
    --       -- },
    --       -- ["core.norg.concealer"] = {},
    --       ["core.norg.journal"] = {
    --         config = {
    --           workspace = "journal"
    --         }
    --       },
    --       ["core.norg.qol.toc"] = {},
    --       ["core.integrations.telescope"] = {},
    --       ["core.promo"] = {},
    --     }
    --   }
    -- end,
    -- dependencies = {"nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope"}
}
