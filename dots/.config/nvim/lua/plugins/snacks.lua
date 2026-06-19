return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  dependencies = {
    "nvim-mini/mini.icons",
  },
  opts = {
    bigfile = { enabled = true },
    explorer = { enabled = false },
    animate = { enabled = true },
    dashboard = { enabled = true },
  },
  config = function(_, opts)
    require("snacks").setup(opts)
  end,
}
