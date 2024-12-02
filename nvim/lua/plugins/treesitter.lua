return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<A-o>",
        node_incremental = "<A-o>",
        scope_incremental = false,
        node_decremental = "<A-i>",
      },
    },
  },
}
