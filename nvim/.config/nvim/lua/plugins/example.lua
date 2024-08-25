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
            ensure_installed = {},
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
      }
    }
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
--  -- change trouble config
--  {
--    "folke/trouble.nvim",
--    -- opts will be merged with the parent spec
--    opts = { use_diagnostic_signs = true },
--  },
--
--  -- disable trouble
--  { "folke/trouble.nvim", enabled = false },
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
--  -- change some telescope options and a keymap to browse plugin files
--  {
--    "nvim-telescope/telescope.nvim",
--    keys = {
--      -- add a keymap to browse plugin files
--      -- stylua: ignore
--      {
--        "<leader>fp",
--        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
--        desc = "Find Plugin File",
--      },
--    },
--    -- change some options
--    opts = {
--      defaults = {
--        layout_strategy = "horizontal",
--        layout_config = { prompt_position = "top" },
--        sorting_strategy = "ascending",
--        winblend = 0,
--      },
--    },
--  },
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
--
--  -- add tsserver and setup with typescript.nvim instead of lspconfig
--  {
--    "neovim/nvim-lspconfig",
--    dependencies = {
--      "jose-elias-alvarez/typescript.nvim",
--      init = function()
--        require("lazyvim.util").lsp.on_attach(function(_, buffer)
--          -- stylua: ignore
--          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
--          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
--        end)
--      end,
--    },
--    ---@class PluginLspOpts
--    opts = {
--      ---@type lspconfig.options
--      servers = {
--        -- tsserver will be automatically installed with mason and loaded with lspconfig
--        tsserver = {},
--      },
--      -- you can do any additional lsp server setup here
--      -- return true if you don't want this server to be setup with lspconfig
--      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
--      setup = {
--        -- example to setup with typescript.nvim
--        tsserver = function(_, opts)
--          require("typescript").setup({ server = opts })
--          return true
--        end,
--        -- Specify * to use this function as a fallback for any server
--        -- ["*"] = function(server, opts) end,
--      },
--    },
--  },
--
--  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
--  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
--  { import = "lazyvim.plugins.extras.lang.typescript" },
--
--  -- add more treesitter parsers
--  {
--    "nvim-treesitter/nvim-treesitter",
--    opts = {
--      ensure_installed = {
--        "bash",
--        "html",
--        "javascript",
--        "json",
--        "lua",
--        "markdown",
--        "markdown_inline",
--        "python",
--        "query",
--        "regex",
--        "tsx",
--        "typescript",
--        "vim",
--        "yaml",
--      },
--    },
--  },
--
--  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
--  -- would overwrite `ensure_installed` with the new value.
--  -- If you'd rather extend the default config, use the code below instead:
--  {
--    "nvim-treesitter/nvim-treesitter",
--    opts = function(_, opts)
--      -- add tsx and treesitter
--      vim.list_extend(opts.ensure_installed, {
--        "tsx",
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
}
