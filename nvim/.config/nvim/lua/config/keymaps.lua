-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Git keymaps
map("n", "<localleader>g", "", { noremap = true, silent = true, desc = "Git" })
map("n", "<localleader>gh", ":Gdiffsplit<CR>", { noremap = true, silent = true, desc = "Git horizontal diff split" })
map("n", "<localleader>gc", ":Git commit<CR>", { noremap = true, silent = true, desc = "Git commit" })
map("n", "<localleader>gv", ":Gvdiffsplit<CR>", { noremap = true, silent = true, desc = "Git vertical diff split" })
map("n", "<localleader>gl", function()
  Snacks.picker.git_log()
end, { desc = "Git log" })
map("n", "<localleader>gL", function()
  Snacks.picker.git_log_file()
end, { desc = "Git log file" })
map("n", "<localleader>gp", ":Git pull<CR>", { noremap = true, silent = true, desc = "Git pull" })
map("n", "<localleader>gP", ":Git push<CR>", { noremap = true, silent = true, desc = "Git push" })
map("n", "<localleader>gs", ":G<CR>", { noremap = true, silent = true, desc = "Git status" })

-- Telescope keymaps
map("n", "<localleader>f", "", { noremap = true, silent = true, desc = "Fuzzy Find " })
map("n", "<localleader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
map("n", "<localleader>fR", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
map("n", "<localleader>fr", "<cmd>Telescope oldfiles cwd_only=true<cr>", { desc = "Fuzzy find recent files in cwd" })
map("n", "<localleader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
map("n", "<localleader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
map("n", "<localleader>fT", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
map("n", "<localleader>ft", function()
  Snacks.terminal()
end, { desc = "Terminal (cwd)" })

map("n", "<localleader>e", function()
  Snacks.explorer.open()
end, { desc = "Snacks explorer open" })
map("n", "<localleader>,", function()
  Snacks.picker.buffers()
end, { desc = "Buffers" })

-- Go to definition in vertical split
map("n", "<localleader>fd", function()
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end, { desc = "Go to definition in a vertical split" })

map("n", "<localleader>s", "", { noremap = true, silent = true, desc = "Search and Replace" })
map("n", "<localleader>sc", function()
  Snacks.picker.commands()
end, { desc = "Commands" })
map("n", "<localleader>sb", function()
  Snacks.picker.buffers()
end, { desc = "Buffers" })

map("n", "<localleader>sf", function()
  Snacks.picker.files()
end, { desc = "Find Files" })

map("n", "<localleader>sg", function()
  Snacks.picker.git_files()
end, { desc = "Find Git Files" })

map("n", "<localleader>sp", function()
  Snacks.picker.projects()
end, { desc = "Projects" })

map("n", "<localleader>sr", function()
  Snacks.picker.recent()
end, { desc = "Recent" })

map("n", "<localleader>ggb", function()
  Snacks.picker.git_branches()
end, { desc = "Git Branches" })

map("n", "<localleader>ggl", function()
  Snacks.picker.git_log()
end, { desc = "Git Log" })

map("n", "<localleader>ggL", function()
  Snacks.picker.git_log_line()
end, { desc = "Git Log Line" })

map("n", "<localleader>ggs", function()
  Snacks.picker.git_status()
end, { desc = "Git Status" })

map("n", "<localleader>ggS", function()
  Snacks.picker.git_stash()
end, { desc = "Git Stash" })

map("n", "<localleader>ggd", function()
  Snacks.picker.git_diff()
end, { desc = "Git Diff (Hunks)" })

map("n", "<localleader>ggf", function()
  Snacks.picker.git_log_file()
end, { desc = "Git Log File" })

map("v", "<localleader>s?", '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Search current word" })
map(
  "n",
  "<localleader>s-",
  '<cmd>lua require("spectre").open_file_search({select_word=false})<CR>',
  { desc = "Search on current file" }
)

-- Snacks help pages
map("n", "<localleader>sh", function()
  Snacks.picker.help()
end, { desc = "Snacks help" })
map("n", "<localleader>su", function()
  Snacks.picker.undo()
end, { desc = "Undo history" })
-- Snacks Search history
map("n", "<localleader>ss", function()
  Snacks.picker.search_history()
end, { desc = "Snacks search history" })

map("n", "<localleader>m", "", { noremap = true, silent = true, desc = "Markdown and Notes" })
map("n", "<localleader>mp", ":MarkdownPreview<CR>", { desc = "Start Markdown Preview" })
map("n", "<localleader>ms", ":MarkdownPreviewStop<CR>", { desc = "Stop Markdown Preview" })

-- Obsidian keymaps
map("n", "<localleader>mn", ":ObsidianNew<CR>", { noremap = true, silent = true, desc = "Create new Obsidian note" })
map("n", "<localleader>ms", ":ObsidianSearch<CR>", { noremap = true, silent = true, desc = "Search in Obsidian" })
map(
  "n",
  "<localleader>mt",
  ":ObsidianToday<CR>",
  { noremap = true, silent = true, desc = "Open today's note in Obsidian" }
)
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
map("n", "<localleader>cv", function()
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end, { desc = "Go to definition in a vertical split" })
map("n", "<localleader>ch", function()
  vim.cmd("split")
  vim.lsp.buf.definition()
end, { desc = "Go to definition in a horizontal split" })

map("n", "<localleader>a", "", { noremap = true, silent = true, desc = "Ai" })
-- map("n", "<localleader>ac", ":CodeiumChatToggle<CR>", { noremap = true, silent = true, desc = "Codeium: Chat" })
map("n", "<localleader>ad", ":Copilot disable<CR>", { noremap = true, silent = true, desc = "Copilot: disable" })
map("n", "<localleader>ae", ":Copilot enable<CR>", { noremap = true, silent = true, desc = "Copilot: enable" })

map("n", "<localleader>ai", "<cmd>ChatGPT<CR>", { noremap = true, silent = true, desc = "ChatGPT" })
map(
  "n",
  "<localleader>ace",
  "<cmd>ChatGPTEditWithInstruction<CR>",
  { noremap = true, silent = true, desc = "Edit with instruction" }
)
map(
  "n",
  "<localleader>acg",
  "<cmd>ChatGPTRun grammar_correction<CR>",
  { noremap = true, silent = true, desc = "Grammar Correction" }
)
map(
  { "n", "v" },
  "<localleader>act",
  "<cmd>ChatGPTRun translate<CR>",
  { noremap = true, silent = true, desc = "Translate" }
)
map(
  { "n", "v" },
  "<localleader>ack",
  "<cmd>ChatGPTRun keywords<CR>",
  { noremap = true, silent = true, desc = "Keywords" }
)
map(
  { "n", "v" },
  "<localleader>acd",
  "<cmd>ChatGPTRun docstring<CR>",
  { noremap = true, silent = true, desc = "Docstring" }
)
map(
  { "n", "v" },
  "<localleader>aca",
  "<cmd>ChatGPTRun add_tests<CR>",
  { noremap = true, silent = true, desc = "Add Tests" }
)
map(
  { "n", "v" },
  "<localleader>aco",
  "<cmd>ChatGPTRun optimize_code<CR>",
  { noremap = true, silent = true, desc = "Optimize Code" }
)
map(
  { "n", "v" },
  "<localleader>acs",
  "<cmd>ChatGPTRun summarize<CR>",
  { noremap = true, silent = true, desc = "Summarize" }
)
map(
  { "n", "v" },
  "<localleader>acf",
  "<cmd>ChatGPTRun fix_bugs<CR>",
  { noremap = true, silent = true, desc = "Fix Bugs" }
)
map(
  { "n", "v" },
  "<localleader>acx",
  "<cmd>ChatGPTRun explain_code<CR>",
  { noremap = true, silent = true, desc = "Explain Code" }
)
map(
  { "n", "v" },
  "<localleader>acr",
  "<cmd>ChatGPTRun roxygen_edit<CR>",
  { noremap = true, silent = true, desc = "Roxygen Edit" }
)
map(
  { "n", "v" },
  "<localleader>acl",
  "<cmd>ChatGPTRun code_readability_analysis<CR>",
  { noremap = true, silent = true, desc = "Code Readability Analysis" }
)
