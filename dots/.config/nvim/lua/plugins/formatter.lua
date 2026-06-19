return {
  "stevearc/conform.nvim",
  lazy = false,
  config = function()
    local javascript = { "prettierd", "prettier" }

    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = javascript,
        typescript = javascript,
      },
      formatters = {
        prettierd = {
          prepend_args = {
            "--single-quote",
            "--semi",
            "--quote-props=as-needed",
            "--end-of-line=lf",
            "--trailing-comma=all",
          },
        },
      },
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "never",
      },
    })

    vim.keymap.set("n", "<leader>f", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end)
  end,
}
