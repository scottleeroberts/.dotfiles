local telescope = {}


function bcommits()
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local actions = require('telescope.actions')
  local previewers = require('telescope.previewers')
  local conf = require('telescope.config').values

  local current_file = vim.fn.expand('%')
  local git_commits = io.popen('git log --pretty=format:"%h %aE %s %cd" --date=short -- ' .. current_file):read('*all')

  local git_commits_table = {}
  for line in git_commits:gmatch("[^\r\n]+") do
    table.insert(git_commits_table, line)
  end

  pickers.new({}, {
    prompt_title = 'Git Commits',
    finder = finders.new_table {
      results = git_commits_table,
      entry_maker = function(line)
        local parts = vim.split(line, " ")
        local sha = table.remove(parts, 1)
        local author = table.remove(parts, 1)
        local date = table.remove(parts, #parts)
        local message = table.concat(parts, " ")
        return {
          value = sha,
          ordinal = line,
          display = "[" .. sha .."] " .. date .. " (" .. author .. ") " .. message,
          date = date,
        }
      end,
    },
    sorter = conf.generic_sorter({}),
    previewer = previewers.new_termopen_previewer({
      get_command = function(entry)
        return { 'git', 'show', entry.value, '--', current_file }
      end,
    }),
    attach_mappings = function(_, map)
      map('i', '<CR>', actions.git_checkout)
      map('n', '<CR>', actions.git_checkout)
      return true
    end,
  }):find()
end

 require('telescope').setup{
  defaults = {
      vimgrep_arguments = {
        'rg',
        '--line-number',
        '--hidden',
        '--column',
        '--smart-case',
        '--follow',
        '--with-filename',
      },
      layout_strategy = "flex",
      layout_config = {
        preview_cutoff = 10,
        width = 0.8,
        height = 0.9,
        flex = {
          flip_columns = 170,
        },
      },
   },
   pickers = {
   },
   extensions = {
      fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
          case_mode = "smart_case",
      }
   }
 }
return telescope
