vim.g.mapleader = " "

-- Nvim Tree --
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Telescopes --
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Search --
vim.keymap.set("n", "<leader>nh", ":nohl<CR>")

-- ESC Insert Mode --
vim.keymap.set("i", "jk", "<ESC>")

-- Split --
vim.keymap.set("n", "<leader>sv", "<C-w>v") 
vim.keymap.set("n", "<leader>sh", "<C-w>s")

-- Format --
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, {})

-- DAP --
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<F9>', "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.api.nvim_set_keymap('n', '<F5>', "<cmd>lua require'dap'.continue()<CR>", opts)
vim.api.nvim_set_keymap('n', '<F10>', "<cmd>lua require'dap'.step_over()<CR>", opts)
vim.api.nvim_set_keymap('n', '<F11>', "<cmd>lua require'dap'.step_into()<CR>", opts)
