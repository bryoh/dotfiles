---- since this is just an example spec, don't actually load anything here and return an empty spec
---- stylua: ignore
----if true then return {} end
--
---- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
----
---- In your plugin files, you can:
---- * add extra plugins
---- * disable/enabled LazyVim plugins
---- * override the configuration of LazyVim plugins
return {
    {
      "folke/tokyonight.nvim",
      opts = {
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      },
    },
    {
      {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
          -- Disable automatic setup, we are doing it manually
          vim.g.lsp_zero_extend_cmp = 0
          vim.g.lsp_zero_extend_lspconfig = 0
        end,
      },
      {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
      },

      -- Autocompletion
      {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
          {'L3MON4D3/LuaSnip'},
        },
        config = function()
          -- Here is where you configure the autocompletion settings.
          local lsp_zero = require('lsp-zero')
          lsp_zero.extend_cmp()

          -- And you can configure cmp even more, if you want to.
          local cmp = require('cmp')
          local cmp_action = lsp_zero.cmp_action()

          cmp.setup({
            formatting = lsp_zero.cmp_format({details = true}),
            mapping = cmp.mapping.preset.insert({
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-u>'] = cmp.mapping.scroll_docs(-4),
              ['<C-d>'] = cmp.mapping.scroll_docs(4),
              ['<C-f>'] = cmp_action.luasnip_jump_forward(),
              ['<C-b>'] = cmp_action.luasnip_jump_backward(),
            }),
            snippet = {
              expand = function(args)
                require('luasnip').lsp_expand(args.body)
              end,
            },
          })
        end
      },

      -- LSP
      {
        'neovim/nvim-lspconfig',
        cmd = {'LspInfo', 'LspInstall', 'LspStart'},
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
          {'hrsh7th/cmp-nvim-lsp'},
          {'williamboman/mason-lspconfig.nvim'},
        },
        config = function()
          -- This is where all the LSP shenanigans will live
          local lsp_zero = require('lsp-zero')
          lsp_zero.extend_lspconfig()

          -- if you want to know more about mason.nvim
          -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
          lsp_zero.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp_zero.default_keymaps({buffer = bufnr})
          end)

          require('mason-lspconfig').setup({
            ensure_installed = {
                'bashls',
                'cssls',
                'dockerls',
                'html',
                'jsonls',
                'pyright',
                'tsserver',
                'vimls',
                'yamlls',
            },
            handlers = {
              -- this first function is the "default handler"
              -- it applies to every language server without a "custom handler"
              function(server_name)
                require('lspconfig')[server_name].setup({})
              end,

              -- this is the "custom handler" for `lua_ls`
              lua_ls = function()
                -- (Optional) Configure lua language server for neovim
                local lua_opts = lsp_zero.nvim_lua_ls()
                require('lspconfig').lua_ls.setup(lua_opts)
              end,
            }
          })
        end
      },
    },
--  -- add gruvbox
--  { "ellisonleao/gruvbox.nvim" },
--
--  -- Configure LazyVim to load gruvbox
--  {
--    "LazyVim/LazyVim",
--    opts = {
--      colorscheme = "gruvbox",
--    },
--  },
--
  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },
--                                           /
  -- disable trouble
  { "folke/trouble.nvim", enabled = false },
--
--  -- override nvim-cmp and add cmp-emoji
--  {
--    "hrsh7th/nvim-cmp",
--    dependencies = { "hrsh7th/cmp-emoji" },
--    ---@param opts cmp.ConfigSchema
--    opts = function(_, opts)
--      table.insert(opts.sources, { name = "emoji" })
--    end,
--  },
--
  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },
    {
      "tpope/vim-fugitive",
      cmd = { "G", "Git" },
      config = function()
        vim.cmd([[
          nnoremap <leader>gs :Git<CR>
          nnoremap <leader>gc :Git commit<CR>
          nnoremap <leader>gp :Git push<CR>
          nnoremap <leader>gl :Git pull<CR>
        ]])
      end,
    },


    {
      "rmagatti/goto-preview",
      event = "BufEnter",
      config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    },
--
--  -- add pyright to lspconfig
--  {
--    "neovim/nvim-lspconfig",
--    ---@class PluginLspOpts
--    opts = {
--      ---@type lspconfig.options
--      servers = {
--        -- pyright will be automatically installed with mason and loaded with lspconfig
--        pyright = {},
--      },
--    },
--  },
    {
      "kawre/leetcode.nvim",--  -- add tsserver and setup with typescript.nvim instead of lspconfig
      build = ":TSUpdate html",--  {
      dependencies = {--    "neovim/nvim-lspconfig",
          "nvim-telescope/telescope.nvim",--    dependencies = {
          "nvim-lua/plenary.nvim", -- required by telescope--      "jose-elias-alvarez/typescript.nvim",
          "MunifTanjim/nui.nvim",--      init = function()
  --        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- optional--          -- stylua: ignore
          "nvim-treesitter/nvim-treesitter",--          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          -- "rcarriga/nvim-notify",--          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
          -- "nvim-tree/nvim-web-devicons",--        end)
      },--      end,
      opts = {--    },
        lang = "python",--    ---@class PluginLspOpts
      },--    opts = {
    },--      ---@type lspconfig.options
  --      servers = {
    { -- LSP Configuration & Plugins--        -- tsserver will be automatically installed with mason and loaded with lspconfig
      'neovim/nvim-lspconfig',--        tsserver = {},
      dependencies = {--      },
        -- Automatically install LSPs to stdpath for neovim--      -- you can do any additional lsp server setup here
        'williamboman/mason.nvim',--      -- return true if you don't want this server to be setup with lspconfig
        'williamboman/mason-lspconfig.nvim',--      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
  --      setup = {
        -- Useful status updates for LSP--        -- example to setup with typescript.nvim
        'j-hui/fidget.nvim',--        tsserver = function(_, opts)
      }--          require("typescript").setup({ server = opts })
    },--          return true
--        end,
--        -- Specify * to use this function as a fallback for any server
--        -- ["*"] = function(server, opts) end,
--      },
--    },
--  },
  {
    "folke/noice.nvim",--  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
    config = function()--  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
      require("noice").setup({--  { import = "lazyvim.plugins.extras.lang.typescript" },
        -- add any options here--
        routes = {--  -- add more treesitter parsers
          {--  {
            filter = {--    "nvim-treesitter/nvim-treesitter",
              event = 'msg_show',--    opts = {
              any = {--      ensure_installed = {
                { find = '%d+L, %d+B' },--        "bash",
                { find = '; after #%d+' },--        "html",
                { find = '; before #%d+' },--        "javascript",
                { find = '%d fewer lines' },--        "json",
                { find = '%d more lines' },--        "lua",
              },--        "markdown",
            },--        "markdown_inline",
            opts = { skip = true },--        "python",
          }--        "query",
        },--        "regex",
        presets = {--        "tsx",
          bottom_search = true, -- use a classic bottom cmdline for search--        "typescript",
          command_palette = true, -- position the cmdline and popupmenu together--        "vim",
          long_message_to_split = true, -- long messages will be sent to a split--        "yaml",
          lsp_doc_border = false, -- add a border to hover docs and signature help--      },
        },--    },
      })--  },
    end,--
    dependencies = {--  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries--  -- would overwrite `ensure_installed` with the new value.
      "MunifTanjim/nui.nvim",--  -- If you'd rather extend the default config, use the code below instead:
      -- OPTIONAL:--  {
      --   `nvim-notify` is only needed, if you want to use the notification view.--    "nvim-treesitter/nvim-treesitter",
      --   If not available, we use `mini` as the fallback--    opts = function(_, opts)
    --   "rcarriga/nvim-notify",--      -- add tsx and treesitter
    }--      vim.list_extend(opts.ensure_installed, {
  },--        "tsx",
--        "typescript",
--      })
--    end,
--  },
--
--  -- the opts function can also be used to change the default opts:
--  {
--    "nvim-lualine/lualine.nvim",
--    event = "VeryLazy",
--    opts = function(_, opts)
--      table.insert(opts.sections.lualine_x, "😄")
--    end,
--  },
--
--  -- or you can return new options to override all the defaults
--  {
--    "nvim-lualine/lualine.nvim",
--    event = "VeryLazy",
--    opts = function()
--      return {
--        --[[add your custom lualine config here]]
--      }
--    end,
--  },
--
--  -- use mini.starter instead of alpha
--  { import = "lazyvim.plugins.extras.ui.mini-starter" },
--
--  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
--  { import = "lazyvim.plugins.extras.lang.json" },
--
--  -- add any tools you want to have installed below
--  {
--    "williamboman/mason.nvim",
--    opts = {
--      ensure_installed = {
--        "stylua",
--        "shellcheck",
--        "shfmt",
--        "flake8",
--      },
--    },
--  },
-- search and replace...
  {"nvim-pack/nvim-spectre"},
  {
    "roobert/activate.nvim",
    keys = {
      {
        "<leader>P",
        '<CMD>lua require("activate").list_plugins()<CR>',
        desc = "Plugins",
      },
    },
    dependencies = {
      { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } }
    }
  },
  {
  "folke/edgy.nvim",
  event = "VeryLazy",
  opts = {}
  },
}
