-- Setup mason with UI icons and ensure tools are installed
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
  ensure_installed = { "clang-format", "codelldb" },
})

-- Setup mason-lspconfig with ensured LSP servers
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "pyright",
    "cssls",
    "jsonls",
    "lua_ls",
    "cmake",
    "hyprls",
    "ts_ls",  -- corrected from ts_ls to tsserver (correct lspconfig name)
  },
})

local status_ok, lsp_zero = pcall(require, 'lsp-zero')

if not status_ok then
    vim.notify("lsp-zero don't exists", "warn")
    return
end

-- lsp_attach is where you enable features that only work
-- if there is a language server active in the file
local lsp_attach = function(client, bufnr)
  local opts = {buffer = bufnr}

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
  vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  vim.keymap.set('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- Dart LSP setup with specific config
require('lspconfig').dartls.setup({
  cmd = { "dart", "language-server" },
  filetypes = { "dart" },
  root_dir = require('lspconfig').util.root_pattern("pubspec.yaml", ".git"),
  on_attach = lsp_attach,
  capabilities = capabilities,
})

