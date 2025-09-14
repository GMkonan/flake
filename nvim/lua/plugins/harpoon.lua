return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon.setup({})
    vim.keymap.set("n", "<leader>h", function() harpoon:list():add() end, { desc = 'Add to [H]arpoon list' })
    vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Open harpoon quick menu" })

    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = 'Go to buffer 1' })
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = 'Go to buffer 2' })
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = 'Go to buffer 3' })
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = 'Go to buffer 4' })
    vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, { desc = 'Go to buffer 5' })

    -- Toggle previous & next buffers stored within Harpoon list
    -- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
    -- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
  end
}
