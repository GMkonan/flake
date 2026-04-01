return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      width = 60,
      row = nil,
      col = nil,
      pane_gap = 4,
      autokeys = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
      preset = {
        pick = nil,
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
        header = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠤⠴⣒⡚⠌⠩⠍⠉⠉⠭⠭⠭⢑⣒⠲⠤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠔⡚⠭⠒⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠒⠭⡓⢤⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣠⢖⡩⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢄⠀⠀⠀⠀⠀⢀⢄⠀⠀⢀⡀⡑⢌⠢⡄⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣠⡾⢕⠏⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⢰⠀⠈⡦⡀⠀⠀⠀⡄⠫⠄⠱⡈⠃⠈⢢⡐⢎⢢⡀⠀⠀
⠀⠀⠀⠀⠀⡼⠏⠀⠈⠀⠀⠀⠀⠀⡜⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡝⣦⠀⠀⠹⡀⠀⠀⠘⡄⠀⠀⠙⡄⠱⡹⡄⠀
⠀⠀⠀⠀⣾⠃⠀⠀⠀⠀⠀⠀⠀⢀⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡎⡌⢆⠀⠀⢱⡄⠀⠀⠘⡄⠀⠀⠘⣴⣔⡹⡆
⠀⠀⠀⢸⠏⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⡇⢘⡌⠇⠀⠘⡽⡀⠀⠀⢣⡀⠀⠀⢱⢿⡵⢱
⠀⠀⠀⣽⠁⠀⠀⠀⡇⠀⠀⠀⠀⢸⠀⠀⠀⠀⢸⡄⠀⢀⠞⠀⠀⠀⠀⠩⡸⡢⠤⡇⢱⡀⠀⠀⢧⠀⠀⠘⣼⢷⠸
⠀⠀⠀⣯⠀⠀⡸⡐⡇⠀⠀⠀⠀⢸⠀⠀⠀⠀⢸⣇⡴⠃⠀⠀⠀⠀⠀⠀⠁⢧⠀⠇⠀⢗⠀⡂⠘⡄⠀⠀⣿⠸⡀
⠀⠀⠀⣿⢰⢸⣇⠁⡇⠀⠀⠀⠀⠀⠀⠀⠀⢀⠜⡋⠀⠀⠀⠀⠀⡇⠀⠀⠀⢸⢸⠀⢀⣸⣶⡷⠁⣱⠀⠀⣿⠀⠥
⠀⠀⠀⣿⣝⢀⡇⠀⡇⠀⠀⠀⠀⢠⠀⡤⠚⠁⣧⠅⠀⠀⠀⠀⠀⠇⠀⠀⠀⢸⣷⣾⡛⠉⡞⠀⠀⣿⠀⠀⠋⢦⠀
⠀⠀⠀⢹⡋⢸⠀⠀⡀⠀⠀⠀⠀⢸⠀⣴⣶⣶⣿⣶⠶⢶⣶⡄⣼⠀⠀⠀⠀⠀⠉⠉⠛⠛⠿⢷⡖⡿⠀⠀⠠⡈⣇
⠀⠀⢀⡟⠀⢸⠀⣿⡇⠀⠀⠀⠀⢸⠀⣀⣀⡜⣬⣴⡾⠛⠓⠂⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⢸⡇⠀⠀⣷⣸
⠀⢀⡞⠀⠀⢸⢾⠁⢳⣤⣄⣀⡀⢸⠀⣠⣶⡿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠇⠀⠀⣏⣿
⣠⠞⠁⠀⠀⠸⣇⠀⢸⠛⠓⠤⠦⢼⠀⠵⠈⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⣀⢀⡠⠤⣤⠀⠀⠀⠀⠀⠰⣦⡴⠚⠁⠉
⡇⠀⠀⣄⠀⠀⠹⣄⢸⡄⠐⠀⠀⠀⡄⠀⠀⠀⠀⠀⠀⠀⢀⠞⠁⠀⠀⠀⠈⠀⠀⠈⠇⠀⠀⠀⢀⡼⢫⡇⠀⠀⠀
⢧⣀⠈⣿⣀⠀⠀⣮⢻⢿⣿⡑⠓⠒⡧⡀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⢀⠆⠀⣠⣴⡏⣠⡟⠀⠀⠀⠀
⠀⠙⢦⣿⠹⣦⡘⣿⣾⠀⠀⠈⠉⠉⣧⣈⡐⠠⢀⡀⠀⠀⠰⣄⠀⠀⢀⡀⠄⠀⣈⡡⣴⢛⣥⠟⡧⠋⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠙⠾⠸⡇⠀⠀⣸⠀⢸⠀⠀⠉⠀⢒⣿⠁⠀⠒⠚⠛⣢⡖⠚⠉⠀⠀⠟⠚⠁⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⡀⠀⣿⠀⢸⡀⠀⢀⡴⣿⣿⣷⣦⣀⡀⢠⣿⣫⡉⠙⠒⡦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠪⠝⢆⣸⣇⠴⢻⠀⢻⣿⣿⣿⣿⣿⣿⣿⣷⡈⢦⡀⠀⡈⢆⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      },
      formats = {
        icon = function(item)
          if item.file and item.icon == 'file' or item.icon == 'directory' then
            return Snacks.dashboard.icon(item.file, item.icon)
          end
          return { item.icon, width = 2, hl = 'icon' }
        end,
        footer = { '%s', align = 'center' },
        header = { '%s', align = 'center' },
        file = function(item, ctx)
          local fname = vim.fn.fnamemodify(item.file, ':~')
          fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
          if #fname > ctx.width then
            local dir = vim.fn.fnamemodify(fname, ':h')
            local file = vim.fn.fnamemodify(fname, ':t')
            if dir and file then
              file = file:sub(-(ctx.width - #dir - 2))
              fname = dir .. '/…' .. file
            end
          end
          local dir, file = fname:match('^(.*)/(.+)$')
          return dir and { { dir .. '/', hl = 'dir' }, { file, hl = 'file' } } or { { fname, hl = 'file' } }
        end,
      },
      sections = {
        { section = 'header' },
        { section = 'keys',   gap = 1, padding = 1 },
        { section = 'startup' },
      },
    },
  },
}
