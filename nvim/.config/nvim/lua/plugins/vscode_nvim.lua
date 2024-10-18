return {
    -- Add the Mofiqul/vscode.nvim colorscheme
    {
        "Mofiqul/vscode.nvim",
        priority = 1000,  -- Load it early
        config = function()
            local vim = vim  -- Ensure vim is defined

            -- Set background to dark or light
            vim.o.background = 'dark' -- You can change this to 'light' for light mode

            -- Enable transparency
            vim.g.vscode_transparent = false

            -- Optional settings
            -- vim.g.vscode_italic_comment = true -- Italic comments
            -- vim.g.vscode_disable_nvimtree_bg = true -- Transparent nvim-tree background

            -- Apply the colorscheme
            vim.cmd([[colorscheme vscode]])
        end,
    },
}
