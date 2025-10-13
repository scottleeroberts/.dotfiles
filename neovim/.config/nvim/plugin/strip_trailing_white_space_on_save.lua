local function strip_trailing_whitespace()
  local cursor_pos = vim.fn.getpos(".")
  vim.cmd([[%s/\s\+$//ge]])
  vim.fn.cursor(cursor_pos[2], cursor_pos[3])
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = strip_trailing_whitespace,
})
