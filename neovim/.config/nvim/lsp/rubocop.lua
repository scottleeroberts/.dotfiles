return {
  cmd = {
    'env', '-u', 'GEM_HOME', '-u', 'GEM_PATH', '-u', 'GEM_ROOT',
    '-u', 'RUBY_ENGINE', '-u', 'RUBY_ROOT', '-u', 'RUBY_VERSION', '-u', 'RUBYLIB', '-u', 'RUBYOPT',
    'mise', 'x', '--', 'rubocop', '--lsp',
  },
  filetypes = { 'ruby' },
  root_markers = { 'Gemfile', '.git' },
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end,
}
