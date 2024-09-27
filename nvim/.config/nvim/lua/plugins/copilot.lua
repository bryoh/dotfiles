return {
    "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = { enabled = true }, -- disable suggestions
      panel = { enabled = true  }, -- disable panel
    })
  end,
}
