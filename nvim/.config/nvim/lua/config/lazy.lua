local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- import/override with your plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    
    -- import/override with your plugins
    { import = "lazyvim.plugins.extras.coding.mini-comment" },
    { import = "lazyvim.plugins.extras.test.core" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    { import = "lazyvim.plugins.extras.editor.refactoring" },
    { import = "lazyvim.plugins.extras.util.octo" },
    { import = "lazyvim.plugins.extras.vscode" },
    { import = "plugins" },
    { import = "plugins.lsp" },

    -- Disable neo-tree
  -- { "nvim-neo-tree/neo-tree.nvim", enabled = false, },

    -- Add barbar.nvim configuration
    { 'romgrk/barbar.nvim',
      dependencies = {
        'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
      },
      init = function()
        vim.g.barbar_auto_setup = false -- Disable automatic setup to configure manually
      end,
      opts = {
        animation = true,
        auto_hide = true,
        tabpages = true,
        closable = true,
        clickable = true,
        icons = true,
        maximum_padding = 1,
        maximum_length = 30,
        no_name_title = 'No Name',
        highlight_alternate = true,
        highlight_inactive_file_icons = false,
        icons = {
          buffer_index = true,
          buffer_number = false,
          button = '',
          filetype = {
            enabled = true,
          },
          separator = { left = '▎', right = '' },
          modified = { button = '●' },
        },
      },
    },

    -- Add the CSV viewer plugin
    -- {
    --   "mechatroner/rainbow_csv",
    --   ft = {"csv", "tsv", "csv_semicolon", "csv_whitespace", "csv_pipe"}, -- file types to enable the plugin
    --   config = function()
    --   end
    -- },
  -- { "nvim-neo-tree/neo-tree.nvim", enabled = false, },
    { "chrisbra/csv.vim", ft = { "csv" },},
  },
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "bufferline",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

