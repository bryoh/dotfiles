return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  "christoomey/vim-tmux-navigator", -- tmux & split window navigation
  "xiyaowong/transparent.nvim",
  {
    "fredrikaverpil/pydoc.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim" }, -- optional
      { "folke/snacks.nvim" }, -- optional
      {
        "nvim-treesitter/nvim-treesitter",
        opts = {
          ensure_installed = { "markdown" },
        },
      },
    },
    cmd = { "PyDoc" },
    opts = {},
  },
}
