-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Git keymaps
map("n", "<localleader>g", "", { noremap = true, silent = true, desc = "Git" })
map("n", "<localleader>gD", ":Gdiffsplit<CR>", { noremap = true, silent = true, desc = "Git horizontal diff split" })
map("n", "<localleader>gc", ":Git commit<CR>", { noremap = true, silent = true, desc = "Git commit" })
map("n", "<localleader>gd", ":Gvdiffsplit<CR>", { noremap = true, silent = true, desc = "Git vertical diff split" })
map("n", "<localleader>gl", ":Git pull<CR>", { noremap = true, silent = true, desc = "Git pull" })
map("n", "<localleader>gp", ":Git push<CR>", { noremap = true, silent = true, desc = "Git push" })
map("n", "<localleader>gs", ":G<CR>", { noremap = true, silent = true, desc = "Git status" })

-- Telescope keymaps
map("n", "<localleader>f", "", { noremap = true, silent = true, desc = "Find and Replace" })
map("n", "<localleader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
map("n", "<localleader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
map("n", "<localleader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
map("n", "<localleader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
map("n", "<localleader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
-- Go to definition in vertical split
map(
  "n",
  "<localleader>fD",
  '<cmd>lua require("telescope.builtin").lsp_definitions{ layout_strategy = "vertical", layout_config = { width = 0.5 }, attach_mappings = function(_, map) map("i", "<CR>", actions.select_vertical); map("n", "<CR>", actions.select_vertical); return true end }<CR>',
  opts
)

map("n", "<localleader>fR", '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre" })
map(
  "n",
  "<localleader>f/",
  '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
  { desc = "Search current word" }
)
map("v", "<localleader>f?", '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Search current word" })
map(
  "n",
  "<localleader>f-",
  '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
  { desc = "Search on current file" }
)
