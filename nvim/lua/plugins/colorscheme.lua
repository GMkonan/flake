local colorscheme = vim.env.KONAN_NVIM_COLORSCHEME or 'tokyonight-night'

local function use_catppuccin(name)
  return name:match '^catppuccin' ~= nil
end

local function tokyonight_style(name)
  local style = name:match '^tokyonight%-(.+)$'
  return style or 'night'
end

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    enabled = use_catppuccin(colorscheme),
    lazy = false,
    priority = 1000,
    init = function()
      require('catppuccin').setup {
        transparent_background = true,
      }

      vim.cmd.colorscheme(colorscheme)
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'folke/tokyonight.nvim',
    enabled = not use_catppuccin(colorscheme),
    lazy = false,
    priority = 1000,
    opts = {
      style = tokyonight_style(colorscheme),
      transparent = true,
      styles = {
        comments = { italic = false },
      },
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd.colorscheme(colorscheme)
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
