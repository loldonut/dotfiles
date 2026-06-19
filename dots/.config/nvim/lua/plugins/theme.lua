return {
  'daedlock/matugen.nvim',
  dependencies = {
    'xiyaowong/transparent.nvim',
  },
  lazy = false,
  priority = 1000,
  config = function()
    require('matugen').setup({
      colors_path = '~/.local/share/dotfiles/nvim/colors.json',
    })
    vim.cmd.colorscheme('matugen')

    require("transparent").setup({
      -- table: default groups
      groups = {
        'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
        'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
        'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
        'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
        'EndOfBuffer',
      },
      -- table: additional groups that should be cleared
      extra_groups = {},
      -- table: groups you don't want to clear
      exclude_groups = {},
      -- function: code to be executed after highlight groups are cleared
      -- Also the user event "TransparentClear" will be triggered
      on_clear = function() end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MatugenReloaded',
      callback = function()
        require('lualine').setup({
          options = { theme = require('matugen').lualine() },
        })

        vim.cmd([[:TransparentEnable]])
      end,
    })
  end,
}
