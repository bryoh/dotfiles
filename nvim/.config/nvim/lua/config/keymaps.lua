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
map("n", "<localleader>mn", ":ObsidianNew<CR>", { noremap = true, silent = true, desc = "Create new Obsidian note" })
map("n", "<localleader>ms", ":ObsidianSearch<CR>", { noremap = true, silent = true, desc = "Search in Obsidian" })
map("n", "<localleader>mt", ":ObsidianToday<CR>", { noremap = true, silent = true, desc = "Open today's note in Obsidian" })
map("n", "<localleader>mg", ":ObsidianTags<CR>", { noremap = true, silent = true, desc = "Show tags in Obsidian" })

-- Toggle Virtual Text keymap
local virtual_text_enabled = true
local function toggle_virtual_text()
  virtual_text_enabled = not virtual_text_enabled
  vim.diagnostic.config({
    virtual_text = virtual_text_enabled,
  })
  if virtual_text_enabled then
    print("Virtual Text: Enabled")
  else
    print("Virtual Text: Disabled")
  end
end

-- Map to toggle virtual text
map("n", "<localleader>c", "", { noremap = true, silent = true, desc = "Code actions" })
map("n", "<localleader>cd", "", { noremap = true, silent = true, desc = "diagnostics" })
map("n", "<localleader>cdiv", toggle_virtual_text, { noremap = true, silent = true, desc = "Inlaytoggle:Virtual Text" })

map("n", "<localleader>a", "", { noremap = true, silent = true, desc = "Codeium " })
map('n', '<localleader>ac', ':CodeiumChatToggle<CR>', { noremap = true, silent = true })
