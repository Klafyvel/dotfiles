require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.summary"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/Documents/neorg/notes",
          writing = "~/Documents/neorg/writing",
          journal = "~/Documents/neorg/journal",
        },
        default_workspace = "notes",
      },
    },
  }
})
