vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = vim.api.nvim_create_augroup('lazy-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank { higroup = 'DiffAdd', timeout = 250 }
  end,
})
