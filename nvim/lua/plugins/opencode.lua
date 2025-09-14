return {
  'NickvanDyke/opencode.nvim',
  dependencies = { 'folke/snacks.nvim', },
  ---@type opencode.Config
  opts = {
    -- Your configuration, if any
  },
  -- https://github.com/NickvanDyke/opencode.nvim
  -- l for LLM
  keys = {
    { '<leader>ll', function() require('opencode').toggle() end,                           desc = 'Toggle embedded opencode', },
    { '<leader>la', function() require('opencode').ask() end,                              desc = 'Ask LLM opencode',                 mode = 'n', },
    { '<leader>la', function() require('opencode').ask('@selection: ') end,                desc = 'Ask LLM opencode about selection', mode = 'v', },
    { '<leader>lp', function() require('opencode').select_prompt() end,                    desc = 'Select prompt',                    mode = { 'n', 'v', }, },
    { '<leader>ln', function() require('opencode').command('session_new') end,             desc = 'New LLM session', },
    { '<leader>ly', function() require('opencode').command('messages_copy') end,           desc = 'Copy last message', },
    { '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end,   desc = 'Scroll messages up', },
    { '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end, desc = 'Scroll messages down', },
  },
}
