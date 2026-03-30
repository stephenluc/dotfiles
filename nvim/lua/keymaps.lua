local map = vim.keymap.set

-- Escape shortcut in insert mode
map("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- Command aliases (carried over from .vimrc)
vim.api.nvim_create_user_command("W", "w", { desc = "Write file (alias for :w)" })
vim.api.nvim_create_user_command("Q", "q", { desc = "Quit (alias for :q)" })
vim.api.nvim_create_user_command("Wq", "wq", { desc = "Write and quit (alias for :wq)" })

-- Leader mappings
map("n", "<leader>h", ":nohl<CR>", { desc = "Clear search highlight" })
map("n", "<leader>w", ":w<CR>", { desc = "Quick save" })
map("n", "<leader>e", ":Explore<CR>", { desc = "Toggle netrw file explorer" })

-- Move selected lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Half-page scroll, keep cursor centered
map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down, centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up, centered" })

-- Search results, keep cursor centered
map("n", "n", "nzzzv", { desc = "Next search result, centered" })
map("n", "N", "Nzzzv", { desc = "Prev search result, centered" })
