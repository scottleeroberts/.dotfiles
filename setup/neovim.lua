local function check()
  assert(vim.fn.has("nvim-0.12") == 1, "Neovim 0.12 or newer required")
  local config = require("lazy.core.config")
  local lock = vim.json.decode(table.concat(vim.fn.readfile(vim.env.DOTFILES_NVIM_EXPECTED_LOCKFILE), "\n"))
  assert(vim.g.colors_name, "No colorscheme loaded")
  assert(vim.fn.exists(":Telescope") == 2, "Telescope commands unavailable")
  assert(vim.fn.exists(":Mason") == 2, "Mason commands unavailable")
  for name, plugin in pairs(config.plugins) do
    for _, task in ipairs(plugin._.tasks or {}) do
      assert(not task:has_errors(), ("Plugin task failed: %s (%s)\n%s"):format(name, task.name, task:output(vim.log.levels.ERROR)))
    end
    local pin = assert(lock[name], "Missing plugin lock: " .. name)
    local result = vim.system({ "git", "-C", plugin.dir, "rev-parse", "HEAD" }, { text = true }):wait()
    assert(result.code == 0, ("Cannot read plugin checkout %s: %s"):format(name, result.stderr))
    local actual = vim.trim(result.stdout)
    assert(actual == pin.commit, ("Plugin %s is at %s, expected %s"):format(name, actual, pin.commit))
  end

  local parsers = require("ts-install.parsers")
  local configured = require("user.config.treesitter").languages
  local languages = vim.fn.uniq(vim.fn.sort(parsers.norm_languages(vim.deepcopy(configured))))
  local install_dir = require("ts-install.config").config.install_dir
  local function missing(names)
    return vim.tbl_filter(function(name)
      local info = parsers.install_info(name)
      local queries = vim.uv.fs_stat(vim.fs.joinpath(install_dir, "queries", name))
      local binary = vim.uv.fs_stat(vim.fs.joinpath(install_dir, "parser", name .. ".so"))
      return not queries or (info and (info.url or info.path) and not binary)
    end, names)
  end
  local pending = missing(languages)
  if vim.env.DOTFILES_NVIM_MODE == "install" and #pending > 0 then
    -- ts-install builds parsers concurrently. Create shared directories first.
    vim.fn.mkdir(vim.fn.stdpath("cache"), "p")
    for _, name in ipairs({ "parser", "parser-info", "queries" }) do
      vim.fn.mkdir(vim.fs.joinpath(install_dir, name), "p")
    end
    local task = require("ts-install.async").run(require("ts-install.install").install, pending, {
      skip = { dependencies = true },
    })
    task:wait(180000)
  end
  local absent = missing(languages)
  assert(#absent == 0, "Missing installed parsers: " .. table.concat(absent, ", "))
  -- Neovim can cache runtime directory lookups before first-run parsers exist.
  if vim.env.DOTFILES_NVIM_MODE == "install" then
    return
  end
  assert(vim.api.nvim_get_runtime_file("parser/ruby.so", false)[1], "Ruby parser is missing from the runtime path")
  vim.cmd.enew()
  local ruby = { "def answer", "  42", "end" }
  vim.api.nvim_buf_set_lines(0, 0, -1, false, ruby)
  vim.bo.filetype = "ruby"
  local parser = vim.treesitter.get_string_parser(table.concat(ruby, "\n"), "ruby")
  local _, tree = next(parser:parse(true) or {})
  assert(tree and tree:root():type() == "program" and not tree:root():has_error(), "Ruby parser failed")
  assert(vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()], "Ruby highlighting did not start")
  assert(require("telescope").extensions.fzf, "Telescope native fzf failed to load")
end

local ok, err = xpcall(check, debug.traceback)
if not ok then
  io.stderr:write(err .. "\n")
  vim.cmd.cquit()
end
vim.cmd("qa!")
