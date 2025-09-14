-- Leader key is Space (set in init.lua)
local opts = { noremap = true, silent = true }

-- Asyncrun keybindings
local function compile_cpp()
  local filepath = vim.fn.expand("%:p")
  local filename = vim.fn.expand("%:t:r")
  local command = string.format("clang++ -std=c++17 %s -o %s.out && ./%s.out", filepath, filename, filename)
  vim.cmd(string.format("AsyncRun %s", command))
end

vim.keymap.set("n", "<leader>cc", compile_cpp, vim.tbl_extend("force", opts, { desc = "Compile and run C++ file" }))
vim.keymap.set("n", "<leader>q", ":copen<CR>", vim.tbl_extend("force", opts, { desc = "Open quickfix window" }))
vim.keymap.set("n", "<leader>Q", ":cclose<CR>", vim.tbl_extend("force", opts, { desc = "Close quickfix window" }))
vim.keymap.set("n", "<leader>qn", ":cnext<CR>", vim.tbl_extend("force", opts, { desc = "Next quickfix item" }))
vim.keymap.set("n", "<leader>qp", ":cprev<CR>", vim.tbl_extend("force", opts, { desc = "Previous quickfix item" }))

-- LSP keybindings
vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))

-- Completion keybinding (handled in cmp.lua, but mapping defined here for consistency)
-- Note: <C-Space> is set in cmp.lua's mapping table; this is optional if already working
vim.keymap.set("i", "<C-Space>", function() require('cmp').complete() end, vim.tbl_extend("force", opts, { desc = "Trigger completion" }))
