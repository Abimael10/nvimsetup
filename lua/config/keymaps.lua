-- Extra keymaps that supplement LazyVim defaults.
local map = vim.keymap.set

map("n", "<leader><leader>x", "<cmd>source %<cr>", { desc = "Source current file" })
map("n", "<leader>x", ":.lua<cr>", { desc = "Eval current line", silent = true })
map("v", "<leader>x", ":lua<cr>", { desc = "Eval selection", silent = true })
