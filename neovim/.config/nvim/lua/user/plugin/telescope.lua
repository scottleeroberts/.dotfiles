local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--line-number',
        '--hidden',
        '--column',
        '--smart-case',
        '--follow'
      },
      prompt_prefix    = ' 🔍 ',
      color_devicons   = true,
      file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
      generic_sorter   = require('telescope.sorters').get_fzy_sorter,
      file_sorter      = require('telescope.sorters').get_fzy_sorter,

      mappings = {
          i = {
              ["<C-s>"] = actions.cycle_previewers_next,
              ["<C-a>"] = actions.cycle_previewers_prev,
          },
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
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  },
  extensions = {
      fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
          case_mode = "smart_case",
      }
  },
}

require('telescope').load_extension('fzy_native')
