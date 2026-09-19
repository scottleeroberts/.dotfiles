if ! command -v mise >/dev/null 2>&1; then
  echo "mise is required to install Ruby" >&2
  return 1
fi

mise install
mise exec -- gem install ruby-lsp --no-document
