-- https://github.com/kylechui/nvim-surround
return {
  'kylechui/nvim-surround',
  version = '*', -- Use for stability; omit to use `main` branch for the latest features
  event = 'VeryLazy',
  config = function()
    require('nvim-surround').setup {
      -- Configuration here, or leave empty to use defaults
      -- cs ([C]hange [S]urrounding + existing_surrounding + new_surrounding)
      -- ds ([D]elete [S]urrounding + existing_surrounding)
      -- etc
    }
  end,
}
