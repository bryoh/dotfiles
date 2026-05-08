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

-- OSC 52 clipboard support (SSH + Tmux compatible)
if vim.env.SSH_TTY or vim.env.SSH_CONNECTION or vim.env.TMUX then
  vim.opt.clipboard = "unnamedplus"

  local function copy(lines, _)
    local s = table.concat(lines, "\n")
    local b64 = vim.base64.encode(s)
    local osc = "\x1b]52;c;" .. b64 .. "\x07"
    if vim.env.TMUX then
      osc = "\x1bPtmux;\x1b" .. osc .. "\x1b\\"
    end
    io.stdout:write(osc)
  end

  local function paste()
    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
  end

  vim.g.clipboard = {
    name = "OSC 52",
    copy = { ["+"] = copy, ["*"] = copy },
    paste = { ["+"] = paste, ["*"] = paste },
  }
end

