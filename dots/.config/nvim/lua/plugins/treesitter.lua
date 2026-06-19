return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require("nvim-treesitter.config").setup({
      ensure_installed = {
        "javascript",
        "typescript",
        "lua",
        "c",
        "cpp",
        "vim",
        "vimdoc",
      },
      sync_installed = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })
  end,
}
