-- Clear trailing spaces
vim.api.nvim_create_autocmd({ 'BufWrite', 'BufWritePre' }, {
  callback = function()
    vim.cmd([[ :%s/\s\+$//e ]])
  end,
})
