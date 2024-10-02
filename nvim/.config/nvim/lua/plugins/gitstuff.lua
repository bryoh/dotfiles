return {
  'f-person/git-blame.nvim',
  {
    'tpope/vim-fugitive',
    event = 'BufRead',
    config = function()
      -- Key mappings for Fugitive with descriptions
      vim.api.nvim_set_keymap('n', '<leader>g<leader>s', ':G<CR>', { noremap = true, silent = true, desc = 'Git status' }) -- Git status
      vim.api.nvim_set_keymap('n', '<leader>g<leader>c', ':Git commit<CR>', { noremap = true, silent = true, desc = 'Git commit' }) -- Git commit
      vim.api.nvim_set_keymap('n', '<leader>g<leader>p', ':Git push<CR>', { noremap = true, silent = true, desc = 'Git push' }) -- Git push
      vim.api.nvim_set_keymap('n', '<leader>g<leader>l', ':Git pull<CR>', { noremap = true, silent = true, desc = 'Git pull' }) -- Git pull
      vim.api.nvim_set_keymap('n', '<leader>g<leader>ds', ':Gvdiffsplit<CR>', { noremap = true, silent = true, desc = 'Git vertical diff split' }) -- Git vertical diff split
      vim.api.nvim_set_keymap('n', '<leader>g<leader>dS', ':Gdiffsplit<CR>', { noremap = true, silent = true, desc = 'Git horizontal diff split' }) -- Git horizontal diff split
    end
  }
}
