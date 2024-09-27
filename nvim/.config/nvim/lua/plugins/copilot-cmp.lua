return {
  "zbirenbaum/copilot-cmp",
  config = function ()
    require("copilot_cmp").setup({
      suggestion = { enabled = true },
      panel = { enabled = true  },

    })

  end
}
