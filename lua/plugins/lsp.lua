require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	},
  ensure_installed = {"clang-format", "codelldb"}
})

require("mason-lspconfig").setup({
	ensure_installed = {"clangd", "pyright", "cssls", "jsonls", "lua_ls", "cmake", "hyprls"}
})

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

local lsp = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lsp.clangd.setup({
	lsp_attach = lsp_attach,
	capabilities = capabilities
})

lsp.pyright.setup({
  lsp_attach = lsp_attach,
	capabilities = capabilities
})

lsp.cmake.setup({
  lsp_attach = lsp_attach,
	capabilities = capabilities
})

lsp.hyprls.setup({
  lsp_attach = lsp_attach,
	capabilities = capabilities
})
