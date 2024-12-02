return {
  "nvim-neorg/neorg",
  version = "v7.0.0",
  -- lazy-load on filetype
  ft = "norg",
  -- options for neorg. This will automatically call `require("neorg").setup(opts)`
  opts = {
    load = {
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.concealer"] = {}, -- Adds pretty icons to your documents
      ["core.dirman"] = { -- Manages Neorg workspaces
        config = {
          workspaces = {
            notes = "~/notes",
          },
          index = "index.norg",
        },
      },
      ["core.autocommands"] = {},
      ["core.integrations.treesitter"] = {},
    },
  },
}
