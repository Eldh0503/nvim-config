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

-- LSP attach function to setup buffer-local keymaps and commands
local lsp_attach = function(client, bufnr)
  local opts = { buffer = bufnr, silent = true, noremap = true }

  local keymap = vim.keymap.set
  keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  keymap({"n", "x"}, "<F3>", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
  keymap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
end


local lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Helper function to setup LSP servers
local function setup_lsp(server)
  lsp[server].setup({
    on_attach = lsp_attach,
    capabilities = capabilities,
  })
end

-- Setup multiple servers in a loop
local servers = { "clangd", "pyright", "cssls", "jsonls", "lua_ls", "cmake", "hyprls", "ts_ls" }
for _, server in ipairs(servers) do
  setup_lsp(server)
end

-- Dart LSP setup with specific config
lsp.dartls.setup({
  cmd = { "dart", "language-server" },
  filetypes = { "dart" },
  root_dir = lsp.util.root_pattern("pubspec.yaml", ".git"),
  on_attach = lsp_attach,
  capabilities = capabilities,
})

