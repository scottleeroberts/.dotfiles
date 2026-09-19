return {
  cmd = {
    'env', '-u', 'GEM_HOME', '-u', 'GEM_PATH', '-u', 'GEM_ROOT',
    '-u', 'RUBY_ENGINE', '-u', 'RUBY_ROOT', '-u', 'RUBY_VERSION', '-u', 'RUBYLIB', '-u', 'RUBYOPT',
    'mise', 'x', '--', 'ruby-lsp', '--use-launcher',
  },
  filetypes = { 'ruby' },
  root_markers = { 'Gemfile', '.git' },
  init_options = {
    formatter = "auto",
  },
  on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
  end,
}
