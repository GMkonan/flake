-- File explorer in a cool way editing like a neovim buffer
--https://www.reddit.com/r/neovim/comments/1are3j5/oil_nvim_lazy_loading_keymaps_not_working/
return {
  'stevearc/oil.nvim',
  lazy = false,
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  keys = {
    {
      mode = 'n',
      '<leader>o',
      '<cmd>Oil<CR>',
      desc = 'Open the Oil file viewer',
    },
  },
}
