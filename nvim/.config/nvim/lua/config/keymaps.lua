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
map("n", "<localleader>f", "", { noremap = true, silent = true, desc = "Fuzzy Find " })
map("n", "<localleader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
map("n", "<localleader>fR", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
map("n", "<localleader>fr", "<cmd>Telescope oldfiles cwd_only=true<cr>", { desc = "Fuzzy find recent files in cwd" })
map("n", "<localleader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
map("n", "<localleader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
map("n", "<localleader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
-- Go to definition in vertical split
map("n", "<localleader>fd", function()
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end, { desc = "Go to definition in a vertical split" })

map("n", "<localleader>s", "", { noremap = true, silent = true, desc = "Search and Replace" })
map("n", "<localleader>sR", '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre" })
map(
  "n",
  "<localleader>s/",
  '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
  { desc = "Search current word on current file" }
)
map("v", "<localleader>s?", '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Search current word" })
map(
  "n",
  "<localleader>s-",
  '<cmd>lua require("spectre").open_file_search({select_word=false})<CR>',
  { desc = "Search on current file" }
)
map("n", "<localleader>m", "", { noremap = true, silent = true, desc = "Markdown and Notes" })
map("n", "<localleader>mp", ":MarkdownPreview<CR>", { desc = "Start Markdown Preview" })
map("n", "<localleader>ms", ":MarkdownPreviewStop<CR>", { desc = "Stop Markdown Preview" })

-- Obsidian keymaps
map("n", "<localleader>mo", ":ObsidianNew<CR>", { noremap = true, silent = true, desc = "Create new Obsidian note" })
