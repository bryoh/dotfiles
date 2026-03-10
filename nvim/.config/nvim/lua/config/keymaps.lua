-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- General
--==============================================================================

map("n", "<localleader>e", function() Snacks.explorer.open() end, { desc = "Explorer" })
map("n", "<localleader>z", function() Snacks.toggle.zoom():toggle() end, { desc = "Zoom Window" })
map("n", "<localleader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<localleader>ft", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })

--==============================================================================
-- Git
--==============================================================================

map("n", "<localleader>g", "", { desc = "Git" })
map("n", "<localleader>gh", "<cmd>Gdiffsplit<cr>", { desc = "Git horizontal diff split" })
map("n", "<localleader>gc", "<cmd>Git commit<cr>", { desc = "Git commit" })
map("n", "<localleader>gv", "<cmd>Gvdiffsplit<cr>", { desc = "Git vertical diff split" })
map("n", "<localleader>gb", function() Snacks.picker.git_branches() end, { desc = "Git branches" })
map("n", "<localleader>gd", function() Snacks.picker.git_diff() end, { desc = "Git diff (hunks)" })
map("n", "<localleader>gl", function() Snacks.picker.git_log() end, { desc = "Git log" })
map("n", "<localleader>gL", function() Snacks.picker.git_log_file() end, { desc = "Git log file" })
map("n", "<localleader>gp", "<cmd>Git pull<cr>", { desc = "Git pull" })
map("n", "<localleader>gP", "<cmd>Git push<cr>", { desc = "Git push" })
map("n", "<localleader>gs", "<cmd>G<cr>", { desc = "Git status" })
map("n", "<localleader>gS", function() Snacks.picker.git_stash() end, { desc = "Git stash" })

--==============================================================================
-- Fuzzy Finding
--==============================================================================

map("n", "<localleader>f", "", { desc = "Fuzzy Find" })
map("n", "<localleader>fe", function() Snacks.explorer.open() end, { desc = "Explorer" })
map("n", "<localleader>ff", function() Snacks.picker.files() end, { desc = "Find files" })
map("n", "<localleader>fr", function() Snacks.picker.recent() end, { desc = "Recent files" })
map("n", "<localleader>fs", function() Snacks.picker.grep() end, { desc = "Find string" })
map("v", "<localleader>fs", function() Snacks.picker.grep_word() end, { desc = "Find selection" })
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
map("n", "<localleader>ss", function() Snacks.picker.search_history() end, { desc = "Search history" })
map("v", "<localleader>sw", function() require("spectre").open_visual() end, { desc = "Search selection" })
map("n", "<localleader>sf", function() require("spectre").open_file_search({ select_word = false }) end, { desc = "Search current file" })

-- Add a localleader keymap to remove empty lines with confirmation on the visually selected files
map("v", "<localleader>r", function() vim.cmd("'<,'>s/^\\s*$\n//gc") end, { desc = "Remove empty lines (selection)" })

--==============================================================================
-- Markdown and Notes
--==============================================================================

map("n", "<localleader>m", "", { desc = "Markdown and Notes" })
map("n", "<localleader>mp", "<cmd>MarkdownPreview<cr>", { desc = "Start Markdown Preview" })
map("n", "<localleader>mP", "<cmd>MarkdownPreviewStop<cr>", { desc = "Stop Markdown Preview" })

--==============================================================================
-- Obsidian
--==============================================================================

map("n", "<localleader>mn", "<cmd>ObsidianNew<cr>", { desc = "Create new Obsidian note" })
map("n", "<localleader>ms", "<cmd>ObsidianSearch<cr>", { desc = "Search in Obsidian" })
map("n", "<localleader>mt", "<cmd>ObsidianToday<cr>", { desc = "Open today's note in Obsidian" })
map("n", "<localleader>mg", "<cmd>ObsidianTags<cr>", { desc = "Show tags in Obsidian" })
map("n", "<localleader>mo", "<cmd>ObsidianOpen<cr>", { desc = "Open Obsidian vault" })
map("n", "<localleader>ml", "<cmd>ObsidianLink<cr>", { desc = "Create a link in Obsidian" })
map("n", "<localleader>mb", "<cmd>ObsidianBacklinks<cr>", { desc = "Show backlinks in Obsidian" })
map("n", "<localleader>mr", "<cmd>ObsidianRename<cr>", { desc = "Rename current note in Obsidian" })
map("n", "<localleader>mc", "<cmd>ObsidianCheck<cr>", { desc = "Run checks in Obsidian" })
map("n", "<localleader>mf", "<cmd>ObsidianFollow<cr>", { desc = "Follow link under cursor in Obsidian" })

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

map("n", "<leader>uv", toggle_virtual_text, { desc = "Toggle virtual text" })
map("n", "<localleader>co", "<cmd>Telescope lsp_definitions<CR>", { desc = "Definitions" })
map("n", "<localleader>cv", "<cmd>vsplit | Telescope lsp_definitions<CR>", { desc = "Definitions in vertical split" })
map("n", "<localleader>ch", "<cmd>split | Telescope lsp_definitions<CR>", { desc = "Definitions in horizontal split" })

--==============================================================================
-- AI (Copilot, ChatGPT)
--==============================================================================

map("n", "<localleader>a", "", { desc = "AI" })
map("n", "<localleader>ad", "<cmd>Copilot disable<cr>", { desc = "Copilot: disable" })
map("n", "<localleader>ae", "<cmd>Copilot enable<cr>", { desc = "Copilot: enable" })
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
