return {
  "nvim-mini/mini.files",
  opts = {
    mappings = {
      go_in_plus = "L",
      go_out_plus = "H",
      scroll_preview_down = "<C-d>",
      scroll_preview_up = "<C-u>",
    },
    windows = {
      preview = true,
      width_preview = 90,
    },
  },
  keys = {
    { "<leader>fm", function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end, desc = "Open mini.files (Directory of Current File)" },
    { "<leader>fM", function() require("mini.files").open(vim.uv.cwd(), true) end, desc = "Open mini.files (CWD)" },
    { "<leader>fd", function() require("mini.files").open(vim.fn.expand("~/dotfiles"), true) end, desc = "Open mini.files at ~/dotfiles" },
    { "<leader>ft", function() require("mini.files").open(vim.fn.expand("~/ax-livia/test"), true) end, desc = "Open mini.files at ~/ax-livia/test" },
  },
}
