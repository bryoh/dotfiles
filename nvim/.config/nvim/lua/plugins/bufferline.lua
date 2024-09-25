return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "tabs",
    },
  },
  config = function()
    local bufferline = require('bufferline')
    -- Ensure the is_enabled function is defined
    local function diagnostic_is_enabled()
      if bufferline and bufferline.diagnostics and bufferline.diagnostics.is_enabled then
        return bufferline.diagnostics.is_enabled()
      else
        -- Fallback to a default value or handle the error
        return false
      end
    end

    -- Replace the existing call with the new function
    local diagnostics_enabled = diagnostic_is_enabled()

  end,
}
