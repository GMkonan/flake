return {
  'mikavilpas/yazi.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = '<f1>',
      open_file_in_vertical_split = '<c-v>',
      open_file_in_horizontal_split = '<c-x>',
      open_file_in_tab = '<c-t>',
      grep_in_directory = '<c-s>',
      replace_in_directory = '<c-g>',
      cycle_open_buffers = '<tab>',
      copy_relative_path_to_selected_files = '<c-y>',
      send_to_quickfix_list = '<c-q>',
      change_working_directory = '<c-\\>',
      open_and_pick_window = '<c-o>',
    },
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1
  end,
  keys = {
    {
      '<leader>y',
      '<cmd>Yazi<cr>',
      desc = 'Open yazi at current file',
    },
    {
      '<leader>Y',
      '<cmd>Yazi cwd<cr>',
      desc = 'Open yazi in working directory',
    },
    {
      '<c-up>',
      '<cmd>Yazi toggle<cr>',
      desc = 'Resume last yazi session',
    },
  },
}
