-- [[ Settings options ]]
require 'general-options'

-- [[ keymaps ]]
require 'mappings'

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  --
  -- See `:help gitsigns` to understand what the configuration keys do

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end
  -- require 'plugins/which-key',
  --
  -- require 'plugins/telescope',
  --
  -- -- LSP Plugins
  -- require 'plugins/lsp',
  --
  -- -- autoformat
  -- require 'plugins/autoformat',
  --
  -- -- auto completes (cmp)
  -- require 'plugins/complete',
  --
  -- -- theme
  -- require 'plugins/colorscheme',
  --
  -- -- Highlight todo, notes, etc in comments
  -- { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  --
  -- -- mini utilities
  -- require 'plugins/mini',
  --
  -- -- highlight/edit/nav code
  -- require 'plugins/treesitter',
  --
  -- -- file explorer buffer like editing with oil
  -- require 'plugins/oil',
  --
  -- -- Tree file explorer
  -- require 'plugins/neotree',
  --
  -- -- comments
  -- require 'plugins/comment',
  --
  -- -- autopairs
  -- require 'plugins/autopairs',
  --
  -- -- render markdown
  -- require 'plugins/rendermd',
  --
  -- -- neovim line config
  -- require 'plugins/line',
  --
  -- -- Add visual color to hex codes
  -- require 'plugins/colorizer',
  --
  -- -- Tab out of parenthesis, curly braces etc
  -- require 'plugins/tabout',
  --
  -- -- surround words/code in () {} "" etc easily
  -- require 'plugins/surround',
  --
  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  { import = 'plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
