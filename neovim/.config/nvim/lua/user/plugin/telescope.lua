local telescope = {}

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
