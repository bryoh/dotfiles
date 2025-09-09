-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

--================================================================ vim.lsp.buf.definition()
-- General
--==============================================================================

map("n", "<localleader>e", function() Snacks.explorer.open() end, { desc = "Explorer" })
map("n", "<localleader>z", function() vim.cmd("tabnew %") end, { desc = "Maximize" })
map("n", "<localleader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<localleader>ft", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })

--==============================================================================
-- Git
--==============================================================================

map("n", "<localleader>g", "", { desc = "Git" })
map("n", "<localleader>gh", ":Gdiffsplit<CR>", { desc = "Git horizontal diff split" })
map("n", "<localleader>gc", ":Git commit<CR>", { desc = "Git commit" })
map("n", "<localleader>gv", ":Gvdiffsplit<CR>", { desc = "Git vertical diff split" })
map("n", "<localleader>gl", function() Snacks.picker.git_log() end, { desc = "Git log" })
map("n", "<localleader>gL", function() Snacks.picker.git_log_file() end, { desc = "Git log file" })
map("n", "<localleader>gp", ":Git pull<CR>", { desc = "Git pull" })
map("n", "<localleader>gP", ":Git push<CR>", { desc = "Git push" })
map("n", "<localleader>gs", ":G<CR>", { desc = "Git status" })
map("n", "<localleader>ggb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
map("n", "<localleader>ggl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
map("n", "<localleader>ggL", function() Snacks.picker.git_log_line() end, { desc = "Git Log Line" })
map("n", "<localleader>ggs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
map("n", "<localleader>ggS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
map("n", "<localleader>ggd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
map("n", "<localleader>ggf", function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })

--==============================================================================
-- Fuzzy Finding (Telescope)
--==============================================================================

map("n", "<localleader>f", "", { desc = "Fuzzy Find" })
map("n", "<localleader>ff", function() Snacks.explorer.open() end, { desc = "Find files" })
map("n", "<localleader>fr", function() Snacks.picker.recent() end, { desc = "Recent files" })
map("n", "<localleader>fs", function() Snacks.picker.grep() end, { desc = "Find string" })
map("v", "<localleader>fs", function() Snacks.picker.grep_word() end, { desc = "Find string under cursor" })
map("n", "<localleader>f/", function() Snacks.picker.search_history() end, { desc = "Search history" })
map("n", "<localleader>fT", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

--==============================================================================
-- Help and Info
--==============================================================================

map("n", "<localleader>h", "", { desc = "Help and Info" })
map("n", "<localleader>hh", function() Snacks.picker.help() end, { desc = "Help Pages" })
map("n", "<localleader>hH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
map("n", "<localleader>hi", function() Snacks.picker.icons() end, { desc = "Icons" })
map("n", "<localleader>hj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
map("n", "<localleader>hk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
map("n", "<localleader>hl", function() Snacks.picker.loclist() end, { desc = "Location List" })
map("n", "<localleader>hm", function() Snacks.picker.marks() end, { desc = "Marks" })
map("n", "<localleader>hM", function() Snacks.picker.man() end, { desc = "Man Pages" })
map("n", "<localleader>hp", function() Snacks.picker.lazy() end, { desc = "Search for Plugin Spec" })
map("n", "<localleader>hq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
map("n", "<localleader>hR", function() Snacks.picker.resume() end, { desc = "Resume" })
map("n", "<localleader>hu", function() Snacks.picker.undo() end, { desc = "Undo History" })

--==============================================================================
-- Search and Replace (Spectre)
--==============================================================================

map("n", "<localleader>s", "", { desc = "Search and Replace" })
map("n", "<localleader>sc", function() Snacks.picker.commands() end, { desc = "Commands" })
map("n", "<localleader>sb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<localleader>sf", function() Snacks.picker.files() end, { desc = "Find Files" })
map("n", "<localleader>sg", function() Snacks.picker.git_files() end, { desc = "Find Git Files" })
map("n", "<localleader>sp", function() Snacks.picker.projects() end, { desc = "Projects" })
map("n", "<localleader>sr", function() Snacks.picker.recent() end, { desc = "Recent" })
map("v", "<localleader>s?", '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Search current word" })
map("n", "<localleader>s-", '<cmd>lua require("spectre").open_file_search({select_word=false})<CR>', { desc = "Search on current file" })
map("n", "<localleader>sh", function() Snacks.picker.help() end, { desc = "Snacks help" })
map("n", "<localleader>su", function() Snacks.picker.undo() end, { desc = "Undo history" })
map("n", "<localleader>ss", function() Snacks.picker.search_history() end, { desc = "Snacks search history" })

--==============================================================================
-- Markdown and Notes
--==============================================================================

map("n", "<localleader>m", "", { desc = "Markdown and Notes" })
map("n", "<localleader>mp", ":MarkdownPreview<CR>", { desc = "Start Markdown Preview" })
map("n", "<localleader>ms", ":MarkdownPreviewStop<CR>", { desc = "Stop Markdown Preview" })

--==============================================================================
-- Obsidian
--==============================================================================

map("n", "<localleader>mn", ":ObsidianNew<CR>", { desc = "Create new Obsidian note" })
map("n", "<localleader>ms", ":ObsidianSearch<CR>", { desc = "Search in Obsidian" })
map("n", "<localleader>mt", ":ObsidianToday<CR>", { desc = "Open today's note in Obsidian" })
map("n", "<localleader>mg", ":ObsidianTags<CR>", { desc = "Show tags in Obsidian" })
map("n", "<localleader>mo", ":ObsidianOpen<CR>", { desc = "Open Obsidian vault" })
map("n", "<localleader>ml", ":ObsidianLink<CR>", { desc = "Create a link in Obsidian" })
map("n", "<localleader>mb", ":ObsidianBacklinks<CR>", { desc = "Show backlinks in Obsidian" })
map("n", "<localleader>mr", ":ObsidianRename<CR>", { desc = "Rename current note in Obsidian" })
map("n", "<localleader>mc", ":ObsidianCheck<CR>", { desc = "Run checks in Obsidian" })
map("n", "<localleader>mf", ":ObsidianFollow<CR>", { desc = "Follow link under cursor in Obsidian" })

--==============================================================================
-- Code Actions and Diagnostics
--==============================================================================

map("n", "<localleader>c", "", { desc = "Code actions" })
map("n", "<localleader>cd", "", { desc = "diagnostics" })

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

map("n", "<localleader>cdiv", toggle_virtual_text, { desc = "Toggle Virtual Text" })
map("n", "<localleader>cv", function() vim.cmd("vsplit"); vim.lsp.buf.definition() end, { desc = "Go to definition in a vertical split" })
map("n", "<localleader>ch", function() vim.cmd("split"); vim.lsp.buf.definition() end, { desc = "Go to definition in a horizontal split" })
map("n", "<localleader>fd", function() vim.cmd("vsplit"); vim.lsp.buf.definition() end, { desc = "Go to definition in a vertical split" })


--==============================================================================
-- AI (Copilot, ChatGPT)
--==============================================================================

map("n", "<localleader>a", "", { desc = "AI" })
map("n", "<localleader>ad", ":Copilot disable<CR>", { desc = "Copilot: disable" })
map("n", "<localleader>ae", ":Copilot enable<CR>", { desc = "Copilot: enable" })
map("n", "<localleader>ai", "<cmd>ChatGPT<CR>", { desc = "ChatGPT" })
map("n", "<localleader>ace", "<cmd>ChatGPTEditWithInstruction<CR>", { desc = "Edit with instruction" })
map("n", "<localleader>acg", "<cmd>ChatGPTRun grammar_correction<CR>", { desc = "Grammar Correction" })
map({ "n", "v" }, "<localleader>act", "<cmd>ChatGPTRun translate<CR>", { desc = "Translate" })
map({ "n", "v" }, "<localleader>ack", "<cmd>ChatGPTRun keywords<CR>", { desc = "Keywords" })
map({ "n", "v" }, "<localleader>acd", "<cmd>ChatGPTRun docstring<CR>", { desc = "Docstring" })
map({ "n", "v" }, "<localleader>aca", "<cmd>ChatGPTRun add_tests<CR>", { desc = "Add Tests" })
map({ "n", "v" }, "<localleader>aco", "<cmd>ChatGPTRun optimize_code<CR>", { desc = "Optimize Code" })
map({ "n", "v" }, "<localleader>acs", "<cmd>ChatGPTRun summarize<CR>", { desc = "Summarize" })
map({ "n", "v" }, "<localleader>acf", "<cmd>ChatGPTRun fix_bugs<CR>", { desc = "Fix Bugs" })
map({ "n", "v" }, "<localleader>acx", "<cmd>ChatGPTRun explain_code<CR>", { desc = "Explain Code" })
map({ "n", "v" }, "<localleader>acr", "<cmd>ChatGPTRun roxygen_edit<CR>", { desc = "Roxygen Edit" })
map({ "n", "v" }, "<localleader>acl", "<cmd>ChatGPTRun code_readability_analysis<CR>", { desc = "Code Readability Analysis" })

--==============================================================================
-- Debugging (DAP)
--==============================================================================

map("n", "<localleader>df", function() require("dap").continue() end, { desc = "Debug Behave Feature" })