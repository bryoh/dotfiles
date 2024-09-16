return {
    "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      --suggestion = { enabled = false }, -- disable suggestions
      --panel = { enabled = false }, -- disable panel
    })
  end,
}