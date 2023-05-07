-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })


vim.api.nvim_set_keymap("n", "<c-h>", ":TmuxNavigateLeft<cr>", { noremap = true, silent = true, desc = "Navigate Left" })
vim.api.nvim_set_keymap("n", "<c-k>", ":TmuxNavigateUp<cr>", { noremap = true, silent = true, desc = "Navigate Up" })
vim.api.nvim_set_keymap("n", "<c-j>", ":TmuxNavigateDown<cr>", { noremap = true, silent = true, desc = "Navigate Down" })
vim.api.nvim_set_keymap("n", "<c-l>", ":TmuxNavigateRight<cr>",
  { noremap = true, silent = true, desc = "Navigate right" })
vim.api.nvim_set_keymap("n", "<c-\\>", ":TmuxNavigatePrevious<cr>",
  { noremap = true, silent = true, desc = "Navigate to previous pane" })

vim.api.nvim_set_keymap("n", "<localleader>lO", ":VimtexCompileSS<cr>",
  { noremap = true, silent = true, desc = "Compile LaTeX time" })



vim.api.nvim_set_keymap("n", "<leader>S", ":setlocal spell spelllang=en_us<cr>",
  { noremap = true, silent = true, desc = "Turn on spell-check" })
