return {
    "epwalsh/obsidian.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      -- "hrsh7th/nvim-cmp",
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    config = function()
      require("obsidian").setup({
        dir = "/mnt/c/Users/B_Nyamu/OneDrive - Domino Printing Sciences/Documents/vault/work",
        -- open_notes_in = "default",
        daily_notes = {
          folder = "dailies",
          date_format = "%Y-%m-%d",
        },
        -- templates = {
        --   folder = "templates",
        --   date_format = "%Y-%m-%d",
        --   time_format = "%H:%M",
        -- },
        -- completion = {
        --   nvim_cmp = true,
        --   min_chars = 2,
        -- },
      })

      vim.keymap.set("n", "<localleader>fo", function()
        require("telescope.builtin").find_files({
          prompt_title = "Search Obsidian Notes",
          cwd = "/mnt/c/Users/B_Nyamu/OneDrive - Domino Printing Sciences/Documents/vault/",
          hidden = true,
        })
      end, { desc = "Search Obsidian Notes" })
    end,
}
