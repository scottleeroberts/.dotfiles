-- Treesitter configuration for Neovim 0.12+
-- Uses built-in vim.treesitter APIs. Parser installation handled by ts-install.nvim.

local max_filesize = 100 * 1024 -- 100 KB

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
  callback = function(args)
    -- Skip large files
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > max_filesize then
      return
    end

    -- Enable treesitter highlighting (no-op if no parser exists for this filetype)
    pcall(vim.treesitter.start, args.buf)

    -- Enable treesitter-based indentation
    vim.bo[args.buf].indentexpr = "v:lua.vim.treesitter.indentexpr()"
  end,
})
