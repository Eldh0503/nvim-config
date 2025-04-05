require("toggleterm").setup({
  size = 40,
  open_mapping = [[<c-\>]],
  hide_number = true,
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mapping = true,
  persist_size = true,
  direction = "float",
  close_on_exit =true,
  shell = vim.o.shell,
  float_opts = {
    border = "double",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})
