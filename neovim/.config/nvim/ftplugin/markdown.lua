-- Soft wrap lines for readability
vim.opt_local.wrap = true

-- Break lines at word boundaries, not mid-word
vim.opt_local.linebreak = true

-- Preserve indentation when wrapping
vim.opt_local.breakindent = true

-- Prevent hard wrapping (no automatic line breaks)
vim.opt_local.textwidth = 0
vim.opt_local.wrapmargin = 0

-- Remove column marker for cleaner appearance
vim.opt_local.colorcolumn = ""

-- Make j/k move by visual lines instead of actual lines when wrapped
vim.keymap.set('n', 'j', 'gj', { buffer = true, noremap = true })
vim.keymap.set('n', 'k', 'gk', { buffer = true, noremap = true })

-- Prevent editing generated markdown files
local first_lines = vim.api.nvim_buf_get_lines(0, 0, 10, false)
for _, line in ipairs(first_lines) do
  if line:lower():match("<!--") and line:lower():match("generated") then
    vim.opt_local.modifiable = false
    vim.opt_local.readonly = true
    break
  end
end
