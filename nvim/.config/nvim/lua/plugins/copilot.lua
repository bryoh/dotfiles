return {

  {
    "zbirenbaum/copilot.lua",
    -- dependencies = {
    --   "hrsh7th/nvim-cmp",
    -- },
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = true }, -- disable suggestions
        panel = { enabled = true }, -- disable panel
      })
    end,
  },
  -- Lazy
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
      api_key_cmd = "op read op://private/OpenAI/credential --no-newline"
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim", -- optional
      "nvim-telescope/telescope.nvim",
    },
  },
}
