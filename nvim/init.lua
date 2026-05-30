vim.o.number = true
vim.o.relativenumber = true
vim.g.mapleader = " "
vim.o.signcolumn = "yes:1"
-- Ask for confirmation to save file that has changes when trying to :q
vim.o.confirm = true
vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamedplus'

vim.opt.tabstop = 4      -- Visual spaces per tab
vim.opt.softtabstop = 4  -- Spaces per tab when editing
vim.opt.shiftwidth = 4   -- Spaces for auto-indent

vim.pack.add {
	"https://github.com/catppuccin/nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/folke/snacks.nvim",
	-- nvim treesitter
	"https://github.com/brenoprata10/nvim-highlight-colors",
	"https://github.com/stevearc/oil.nvim"
}
vim.cmd.colorscheme("catppuccin")

-- LSP stuff
local servers = {
  ts_ls = "typescript-language-server",
  lua_ls = "lua-language-server",
  pyright = "pyright-langserver",
  gopls = "gopls",
  rust_analyzer = "rust-analyzer",
}

-- Small setting to disable vim undefined global problem cuz I find it annoying
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "Snacks" },
      },
    },
  },
})

for server, executable in pairs(servers) do
  if vim.fn.executable(executable) == 1 then
    vim.lsp.enable(server)
  end
end

-- Auto complete (Via Lsp to have docs)
vim.o.autocomplete = true
vim.o.completeopt = "menuone,noselect,popup"

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my-lsp-completion", { clear = true }),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, {
        autotrigger = true,
      })
    end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

require("oil").setup()
require('nvim-highlight-colors').setup({})

require("snacks").setup({
  picker = {
    enabled = true,
  },

  -- optional, but useful
  input = {
    enabled = true,
  },

  notifier = {
    enabled = true,
  },

  git = {
    enabled = true,
  },

  statuscolumn = {
    enabled = true
  },
})

-- Keymaps
vim.keymap.set("n", "<leader>sf", function()
  Snacks.picker.files()
end, { desc = "Find files" })

-- Toggle live grep <C-g>
vim.keymap.set("n", "<leader>sg", function()
  Snacks.picker.grep()
end, { desc = "Grep" })

-- no idea what is the difference between that and just find files
vim.keymap.set("n", "<leader>ss", function()
  Snacks.picker.smart()
end, { desc = "Smart find files" })

vim.keymap.set("n", "<leader><leader>", function()
  Snacks.picker.buffers()
end, { desc = "Buffers" })

vim.keymap.set("n", "gd", function()
  Snacks.picker.lsp_references()
end, { desc = "LSP References" })

vim.keymap.set("n", "ghi", function()
  Snacks.picker.gh_issue()
end, { desc = "GitHub Issues (open)" })


vim.keymap.set("n", "gb", function()
  Snacks.git.blame_line()
end, { desc = "Git blame line" })

