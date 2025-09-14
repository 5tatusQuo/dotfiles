-- Set leader key
vim.g.mapleader = " "

-- Bootstrap lazy.nvim
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
  { "neovim/nvim-lspconfig" }, -- LSP
  { "hrsh7th/nvim-cmp" }, -- Autocompletion
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "skywind3000/asyncrun.vim" }, -- C++ compilation
  { "nvim-lualine/lualine.nvim" }, -- Statusline
  { "folke/tokyonight.nvim" }, -- Theme
  { "ellisonleao/gruvbox.nvim" }, -- Gruvbox theme
})

-- Load configurations
require("config.options")
require("config.lsp")
require("config.cmp")
require("config.treesitter")
require("config.lualine")
require("config.asyncrun")
require("config.keybindings")

-- Theme
vim.cmd [[colorscheme gruvbox]]
