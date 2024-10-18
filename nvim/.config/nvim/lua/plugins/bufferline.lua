return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      -- Bufferline setup
      require("bufferline").setup({
        options = {
          numbers = function(opts)
            return string.format('%s·%s', opts.id, opts.raise(opts.ordinal))
          end,
          diagnostics = false, -- Disable diagnostics to avoid errors
          separator_style = "slant", -- Use a clean slanted separator style
          show_buffer_close_icons = true,
          show_close_icon = false, -- Hide the global close icon
          always_show_bufferline = true,
          show_tab_indicators = true, -- Show buffer/tab indicators for clarity
          indicator = {
            style = 'underline', -- Underline the active buffer
          },
          max_name_length = 18, -- Limit name length for buffers
          max_prefix_length = 15, -- Limit prefix length for directory names
          hover = {
            enabled = true,
            delay = 200, -- Time in ms before hover is triggered
            reveal = {'close'} -- Shows close button on hover
          },
          -- Enable pinning for buffers
          custom_areas = {
            right = function()
              return {
                { text = '📌', guifg = '#ff8800' }, -- Pin icon
              }
            end,
          },
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            },
          },
        },
      })

      -- Set color highlights for bufferline
      --vim.cmd([[
      --  highlight BufferLineFill guibg=#1e222a
      --  highlight BufferLineBackground guibg=#2e323a guifg=#abb2bf
      --  highlight BufferLineBufferSelected guibg=#1e222a guifg=#ffffff gui=bold
      --  highlight BufferLineBufferVisible guibg=#2e323a guifg=#abb2bf
      --  highlight BufferLineModified guibg=#2e323a guifg=#61afef
      --]])

    end,
  },
}
