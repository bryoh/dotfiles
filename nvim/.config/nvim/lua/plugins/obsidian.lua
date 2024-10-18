return {
  {
    'epwalsh/obsidian.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'neovim/nvim-lspconfig',
      -- Add markdown-preview.nvim as a dependency
      -- {
      --   'iamcco/markdown-preview.nvim',
      --   build = "cd app && npm install",  -- Install dependencies for markdown preview
      --   ft = "markdown",  -- Load plugin only for markdown files
      --   config = function()
      --     -- Setup for markdown-preview.nvim
      --     vim.g.mkdp_auto_start = 1        -- Auto-start preview when opening markdown files
      --     vim.g.mkdp_auto_close = 0        -- Keep the preview open when switching files
      --     vim.g.mkdp_refresh_slow = 1      -- Slow refresh rate for better performance
      --   end,
      -- },
      -- Add telescope for fuzzy searching through notes
      {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },  -- Ensure plenary is installed for Telescope
      },
    },
    config = function()
      -- Setup for obsidian.nvim
      require("obsidian").setup({
        dir = "/mnt/c/Users/B_Nyamu/OneDrive - Domino Printing Sciences/Documents/vault/work",  -- Path to Obsidian vault
        completion = {
          nvim_cmp = true,  -- If using nvim-cmp for completion
          min_chars = 2,    -- Minimum number of characters before completion starts
        },
      })

      -- Optionally, setup keybindings for markdown preview
      vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", { desc = "Start Markdown Preview" })
      vim.keymap.set("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { desc = "Stop Markdown Preview" })

      -- Use Telescope to search for files in Obsidian vault
      vim.keymap.set("n", "<leader>fo", function()
        require("telescope.builtin").find_files({
          prompt_title = "Search Obsidian Notes",
          cwd = "/mnt/c/Users/B_Nyamu/OneDrive - Domino Printing Sciences/Documents/vault/",
          hidden = true,
        })
      end, { desc = "Search Obsidian Notes" })
    end
  }
}

