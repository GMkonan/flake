local theme_plugin = vim.env.KONAN_NVIM_THEME_PLUGIN or 'tokyonight'
local colorscheme = vim.env.KONAN_NVIM_COLORSCHEME or 'tokyonight-night'

local function use_plugin(name)
  return theme_plugin == name
end

local function tokyonight_style(name)
  local style = name:match '^tokyonight%-(.+)$'
  return style or 'night'
end

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    enabled = use_plugin 'catppuccin',
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
    'sainnhe/gruvbox-material',
    enabled = use_plugin 'gruvbox-material',
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.gruvbox_material_background = 'medium'
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_enable_italic = 0

      vim.cmd.colorscheme(colorscheme)
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'folke/tokyonight.nvim',
    enabled = use_plugin 'tokyonight',
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
