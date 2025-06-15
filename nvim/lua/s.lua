require('lspconfig').pyright.setup{}

vim.diagnostic.config({
    virtual_text = false
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'ge', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end
})
