return {
  {
    "yetone/avante.nvim",
    build = vim.fn.has("win32") ~= 0
        and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false,
    keys = {
      { "<localleader>aa", "<cmd>AvanteToggle<cr>", desc = "Avante" },
      { "<localleader>ap", "<cmd>AvanteSwitchProvider copilot<cr>", desc = "Avante: switch to Copilot" },
      { "<localleader>ag", "<cmd>AvanteSwitchProvider gemini-cli<cr>", desc = "Avante: switch to Gemini" },
      { "<localleader>ax", "<cmd>AvanteSwitchProvider codex<cr>", desc = "Avante: switch to Codex" },
    },
    opts = {
      provider = "copilot",
      auto_suggestions_provider = "copilot",
      input = {
        provider = "snacks",
      },
      acp_providers = {
        ["gemini-cli"] = {
          command = "gemini",
          args = { "--model", "gemini-2.5-flash", "--experimental-acp" },
          env = {
            NODE_NO_WARNINGS = "1",
            GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
            GEMINI_MODEL = "gemini-2.5-flash",
          },
        },
        ["codex"] = {
          command = "npx",
          args = { "@zed-industries/codex-acp" },
          env = {
            NODE_NO_WARNINGS = "1",
            OPENAI_API_KEY = os.getenv("OPENAI_API_KEY"),
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "stevearc/dressing.nvim",
      "folke/snacks.nvim",
      "zbirenbaum/copilot.lua",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "Avante" },
        opts = {
          file_types = { "markdown", "Avante" },
        },
      },
    },
  },
}
