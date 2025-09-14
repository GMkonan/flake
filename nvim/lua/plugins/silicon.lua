return {
  'michaelrommel/nvim-silicon',
  lazy = true,
  cmd = 'Silicon',
  main = 'nvim-silicon',
  init = function()
    local wk = require 'which-key'
    wk.add {
      mode = { 'v' },
      {
        '<leader>sc',
        function()
          require('nvim-silicon').clip()
        end,
        desc = 'Copy code screenshot to clipboard',
      },
    }
  end,
  config = function()
    require('nvim-silicon').setup {
      theme = 'Dracula',
      window_title = function()
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ':t')
      end,
    }
  end,
}
