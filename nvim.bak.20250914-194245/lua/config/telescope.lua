require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
      },
    },
  },
}

-- Keybindings (similar to ThePrimeagen)
vim.keymap.set('n', '<leader>pv', require('telescope.builtin').find_files, { desc = 'Telescope: Find files' })
vim.keymap.set('n', '<C-p>', require('telescope.builtin').git_files, { desc = 'Telescope: Git files' })
vim.keymap.set('n', '<leader>ps', function()
  require('telescope.builtin').grep_string { search = vim.fn.input("Grep > ") }
end, { desc = 'Telescope: Grep project' })
