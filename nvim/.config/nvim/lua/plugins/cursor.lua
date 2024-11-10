return {
  {
    --install mini.cursorword
    "echasnovski/mini.cursorword",
    config = function()
      require("mini.cursorword").setup()
    end,

  },
  -- install modicator.nvim
  {
    "mawkler/modicator.nvim",
    dependencies = "mawkler/onedark.nvim",
    init = function()
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    opts = {
      show_warnings = true,
    },
  },
  -- install multicursor
  -- {
  --   "mg979/vim-visual-multi",
  -- }
}
