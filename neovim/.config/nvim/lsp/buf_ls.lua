return {
  cmd = { 'buf', 'lsp', 'serve', '--log-format=text' },
  filetypes = { 'proto' },
  root_markers = { 'buf.yaml', '.git' },
  reuse_client = function(client, config)
    return client.name == config.name
  end,
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
}
