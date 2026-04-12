-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
local opt_global = vim.opt_global
local fn = vim.fn -- invoke vim-functions in lua

-- vim.g.editorconfig = false
-- vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[\]]
-- vim.g.codeium_chat_embedded = true
-- vim.g.codeium_chat_in_editor = true

-- Enable OSC 52 clipboard support for SSH sessions
-- This allows Neovim to update the local system clipboard via the terminal emulator
if vim.env.SSH_TTY or vim.env.SSH_CONNECTION then
  print("SSH detected, setting OSC 52")
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = function(lines) require("vim.ui.clipboard.osc52").copy("+")(lines) end,
      ["*"] = function(lines) require("vim.ui.clipboard.osc52").copy("*")(lines) end,
    },
    paste = {
      ["+"] = function() return require("vim.ui.clipboard.osc52").paste("+")() end,
      ["*"] = function() return require("vim.ui.clipboard.osc52").paste("*")() end,
    },
  }
end
vim.opt.clipboard = "unnamedplus"
print("Clipboard has provider: " .. tostring(vim.fn.has('clipboard')))
print("Clipboard option is: " .. vim.o.clipboard)
