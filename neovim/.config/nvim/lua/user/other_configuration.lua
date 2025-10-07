-- ============================================================================
-- Cursorline Highlighting
-- ============================================================================
-- Show cursorline only in the active window to make it easier to identify
-- which window has focus. The cursorline is hidden when switching to other
-- windows.
local cursorline_group = vim.api.nvim_create_augroup("CursorLine", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  group = cursorline_group,
  pattern = "*",
  callback = function()
    vim.opt_local.cursorline = true
  end,
  desc = "Enable cursorline in active window",
})

vim.api.nvim_create_autocmd("WinLeave", {
  group = cursorline_group,
  pattern = "*",
  callback = function()
    vim.opt_local.cursorline = false
  end,
  desc = "Disable cursorline when leaving window",
})

vim.api.nvim_set_hl(0, "CursorLine", { bg = "#003053" })
vim.opt.cursorline = true

-- ============================================================================
-- Restore Cursor Position
-- ============================================================================
-- When opening a file, automatically jump to the last known cursor position
-- if it's a valid location within the file.
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
  desc = "Restore cursor position when opening file",
})

-- ============================================================================
-- Highlight on Yank
-- ============================================================================
-- Briefly highlight yanked text to provide visual feedback about what was
-- copied. The highlight lasts for 250ms.
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 250,
      on_visual = true,
    })
  end,
  desc = "Highlight yanked text briefly",
})
