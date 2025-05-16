-- Asyncrun settings for C++ compilation
vim.g.asyncrun_open = 6  -- Open quickfix window with 6 lines height after running
vim.g.asyncrun_save = 1  -- Auto-save before running AsyncRun

-- Function to compile C++ file
local function compile_cpp()
  local filepath = vim.fn.expand("%:p")  -- Get full path of current file
  local filename = vim.fn.expand("%:t:r")  -- Get filename without extension
  local command = string.format("g++ -std=c++17 %s -o %s.out && ./%s.out", filepath, filename, filename)
  vim.cmd(string.format("AsyncRun %s", command))
end

-- Auto-compile on save for .cpp files
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.cpp",
  callback = function()
    compile_cpp()
  end,
})

-- Keybinding to manually trigger compilation
vim.keymap.set("n", "<leader>cc", compile_cpp, { desc = "Compile and run C++ file" })
