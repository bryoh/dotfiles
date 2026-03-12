return {
  "epwalsh/obsidian.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
  },
  config = function()
    require("obsidian").setup({
      workspaces = {
        {
          name = "work",
          path = "/mnt/c/Users/B_Nyamu/OneDrive - Domino Printing Sciences/Documents/vault/work",
        },
      },
      daily_notes = {
        folder = "10 Journal/Daily",
        date_format = "%Y-%m-%d",
      },
      templates = {
        folder = "90 Assets/Internal",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },
      -- Customizing how note IDs/filenames are generated to match the ID-Title format
      note_id_func = function(title)
        local suffix = ""
        if title ~= nil then
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,
    })

    -- Existing telescope mapping updated for the new structure
    vim.keymap.set("n", "<localleader>fo", function()
      require("telescope.builtin").find_files({
        prompt_title = "Search Obsidian Notes",
        cwd = "/mnt/c/Users/B_Nyamu/OneDrive - Domino Printing Sciences/Documents/vault/work",
        hidden = true,
      })
    end, { desc = "Search Obsidian Notes" })
  end,
}
