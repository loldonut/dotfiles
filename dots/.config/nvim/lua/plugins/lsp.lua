return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",

    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",

    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",

    "j-hui/fidget.nvim",
  },
  config = function()
    require("fidget").setup()
    require("mason").setup()

    local cmp = require("cmp")

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })

    local capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )

    local language_servers = {
      "ts_ls",
      "pyright",
      "eslint",
      "html",
      "jsonls",
    }

    require("mason-lspconfig").setup({
      ensure_installed = language_servers,
      handlers = {
        function(server_name)
          vim.lsp.enable(server_name)
        end,
      },
    })

    -- TODO: Use handlers
    -- Clangd and LuaLS currently does not support termux
    -- so I have to manually set this up
    vim.lsp.enable("clangd", {
      capabilities = capabilities,
    })
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
      capabilities = capabilities,
    })
    vim.lsp.config("rust_analyzer", {
      capabilities = capabilities,
    })

    vim.lsp.enable("lua_ls", {
      capabilities = capabilities,
    })

    vim.lsp.enable("gopls", {
      capabilities = capabilities,
    })

    -- TODO: Maybe make a file that resolves augroups/autocmd?
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>dr", vim.lsp.buf.rename, opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>rd", vim.lsp.buf.rename, opts)
      end,
    })
  end,
}
