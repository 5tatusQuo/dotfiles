local harpoon = require('harpoon')

harpoon:setup()

-- Keybindings
vim.keymap.set("n", "<leader>hh", function() harpoon:list():append() end, { desc = 'Harpoon: Mark file' })
vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = 'Harpoon: Next file' })
vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = 'Harpoon: Previous file' })
vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon: Show menu' })
