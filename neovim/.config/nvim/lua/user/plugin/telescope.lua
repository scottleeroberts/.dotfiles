local telescope = {}
local previewers = require'telescope.previewers'

-- Custom previewer for git commits
local git_commit_previewer = previewers.new_termopen_previewer {
  get_command = function(entry)
    return {'git', 'show', '--date=short', '--pretty=format:%C(yellow)%h %Cblue%>(12)%ad %Cgreen%<(7)%aN%Cred%d %Creset%s', entry.value}
  end
}

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
      git_commits = {
        previewer = git_commit_previewer,
      },
      git_bcommits = {
        previewer = git_commit_previewer,
      },
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
