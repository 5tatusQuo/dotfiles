-- Set the runtime path for lazy.nvim
vim.g.mapleader = " " -- Set leader key to space
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
  -- LSP and autocompletion
  { "neovim/nvim-lspconfig" }, -- LSP configurations
  { "hrsh7th/nvim-cmp" },      -- Autocompletion
  { "hrsh7th/cmp-nvim-lsp" },  -- LSP source for nvim-cmp
  { "L3MON4D3/LuaSnip" },      -- Snippet engine
  { "saadparwaiz1/cmp_luasnip" }, -- Snippet completion

  -- C++ specific
  { "p00f/clangd_extensions.nvim" }, -- clangd enhancements

  -- Utilities
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- Syntax highlighting
  { "tpope/vim-fugitive" }, -- Git integration
  { "nvim-lualine/lualine.nvim" }, -- Statusline
  { "folke/tokyonight.nvim" }, -- Theme

  { "skywind3000/asyncrun.vim" },
})

-- Basic settings
vim.opt.number = true         -- Show line numbers
vim.opt.tabstop = 2           -- 2 spaces for tabs
vim.opt.shiftwidth = 2        -- 2 spaces for indentation
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.smartindent = true    -- Smart indentation
vim.opt.termguicolors = true  -- Enable true colors

-- Set theme
vim.cmd [[colorscheme tokyonight]]

-- Load additional configurations
require("config.lsp")      -- LSP setup
require("config.cmp")      -- Autocompletion setup
require("config.treesitter") -- Treesitter setup
require("config.lualine")  -- Lualine setup
require("config.asyncrun")

-- Keybinds
-- Quickfix keybindings
vim.keymap.set("n", "<leader>q", ":copen<CR>", { desc = "Open quickfix window" })
vim.keymap.set("n", "<leader>Q", ":cclose<CR>", { desc = "Close quickfix window" })
-- Navigate quickfix list
vim.keymap.set("n", "<leader>qn", ":cnext<CR>", { desc = "Next quickfix item" })
vim.keymap.set("n", "<leader>qp", ":cprev<CR>", { desc = "Previous quickfix item" })
vim.keymap.set("n", "<leader>qf", ":cfirst<CR>", { desc = "First quickfix item" })
vim.keymap.set("n", "<leader>ql", ":clast<CR>", { desc = "Last quickfix item" })
