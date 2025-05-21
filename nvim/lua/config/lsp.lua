local lsp = require('lspconfig')

-- Lua
lsp.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

-- C++
lsp.clangd.setup {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  cmd = { "clangd", "--background-index", "--completion-style=bundled" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = lsp.util.root_pattern("compile_commands.json", ".git") or vim.loop.cwd(),
}
