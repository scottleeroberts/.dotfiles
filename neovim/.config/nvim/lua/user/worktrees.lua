-- Git worktree switcher built on snacks.picker. Selecting a worktree :cd's into it.
local M = {}

---@return {path: string, branch: string?, bare: boolean}[]?
local function list()
  local out = vim.fn.systemlist({ "git", "worktree", "list", "--porcelain" })
  if vim.v.shell_error ~= 0 then
    return nil
  end
  local items, cur = {}, nil
  for _, line in ipairs(out) do
    local path = line:match("^worktree (.+)")
    if path then
      cur = { path = path, bare = false }
      items[#items + 1] = cur
    elseif cur then
      local branch = line:match("^branch refs/heads/(.+)")
      if branch then
        cur.branch = branch
      elseif line == "detached" then
        cur.branch = "(detached)"
      elseif line == "bare" then
        cur.bare = true
      end
    end
  end
  return items
end

function M.pick()
  local worktrees = list()
  if not worktrees then
    vim.notify("Not in a git repository", vim.log.levels.WARN)
    return
  end
  local cwd = vim.uv.cwd()
  local items = {}
  for _, wt in ipairs(worktrees) do
    local label = wt.branch or (wt.bare and "(bare)" or "(unknown)")
    items[#items + 1] = {
      text = label .. " " .. wt.path,
      file = wt.path,
      label = label,
      path = wt.path,
      current = wt.path == cwd,
    }
  end
  require("snacks").picker({
    title = "Git Worktrees",
    items = items,
    layout = { preset = "select" },
    format = function(item)
      return {
        { item.current and "* " or "  ", "SnacksPickerSpecial" },
        { item.label, "SnacksPickerGitBranch" },
        { "  " },
        { item.path, "SnacksPickerDir" },
      }
    end,
    confirm = function(picker, item)
      picker:close()
      if item then
        vim.cmd.cd(vim.fn.fnameescape(item.path))
        vim.notify("cd " .. item.path)
      end
    end,
  })
end

return M
