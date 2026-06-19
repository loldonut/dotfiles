return {
  'nvim-lualine/lualine.nvim',
  config = function ()
    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = require('matugen').lualine(),
        component_seperators = { left = ' ', right = ' ' },
        section_seperators = { left = ' ', right = ' ' },
        globalstatus = true,
      },
      sections = {
        lualine_a = { {
          'buffers',
        } },
      },
    })
  end
}
