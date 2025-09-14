-- Autoformat with conform.nvim
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    default_format_opts = { async = true, lsp_fallback = true },
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      rust = { 'rustfmt' },

      javascript = { 'biome-check', 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'biome-check', 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'biome-check', 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'biome-check', 'prettierd', 'prettier', stop_after_first = true },
      html = { 'biome-check', 'prettierd', stop_after_first = true },
      json = { "biome-check", "prettierd", "prettier", stop_after_first = true },
      jsonc = { "biome-check", "prettierd", stop_after_first = true },
      css = { "biome-check", "prettierd", "prettier", stop_after_first = true },
      nix = { 'alejandra' },
    },
    formatters = {
      ['biome-check'] = {
        command = 'biome',
      },
      -- Uncomment if you want to enable prettierd with config detection
      -- prettierd = {
      --   condition = function()
      --     return vim.fs.find({'.prettierrc', '.prettierrc.js', '.prettierrc.json'}, {
      --       upward = true,
      --     })[1] ~= nil
      --   end,
      -- },
    },
  },
}
