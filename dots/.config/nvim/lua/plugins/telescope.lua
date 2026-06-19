return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "BurntSushi/ripgrep",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  tag = "v0.1.9",
  config = function()
    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
    vim.keymap.set("n", "<C-p>", builtin.git_files, {})
    vim.keymap.set("n", "<leader>fd", builtin.buffers, {})
    vim.keymap.set("n", "<leader>ps", function()
      builtin.grep_string({
        search = vim.fn.input("Grep > "),
      })
    end)

    vim.keymap.set("n", "<leader>pd", builtin.lsp_references, {})

    require("telescope").setup({
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
      defaults = {
        file_ignore_patterns = {
          "node_modules",
        },
      },
      pickers = {
        buffers = {
          show_all_buffers = true,
          sort_lastused = true,
          previewer = false,
          mappings = {
            i = {
              ["<c-d>"] = "delete_buffer",
            },
          },
        },
      },
    })

    require("telescope").load_extension("fzf")
  end,
}
