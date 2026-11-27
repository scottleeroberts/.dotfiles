-- Bootstrap lazy.nvim if not installed
local lockfile = vim.env.DOTFILES_NVIM_LOCKFILE or vim.fn.stdpath("config") .. "/lazy-lock.json"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local result = vim.system({
    "git",
    "clone",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }, { text = true }):wait()
  assert(result.code == 0, result.stderr)
  local lock = vim.json.decode(table.concat(vim.fn.readfile(lockfile), "\n"))
  local checkout = vim.system({ "git", "-C", lazypath, "checkout", "--quiet", lock["lazy.nvim"].commit },
    { text = true }):wait()
  assert(checkout.code == 0, checkout.stderr)
end
vim.opt.rtp:prepend(lazypath)

-- Load all plugin specs from plugins/ directory
require("lazy").setup({
  lockfile = lockfile,
  -- Full clones avoid follow-up network fetches when checking out old pins.
  git = { filter = vim.env.DOTFILES_NVIM_MODE ~= "install" },
  concurrency = vim.env.DOTFILES_NVIM_MODE == "install" and 6 or nil,
  headless = vim.env.DOTFILES_NVIM_MODE and { process = false, task = false, colors = false } or nil,
  install = { missing = vim.env.DOTFILES_NVIM_MODE ~= "verify" },
  spec = {
    { import = "user.plugins" },
  },
  defaults = {
    lazy = false, -- plugins are not lazy-loaded by default
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
