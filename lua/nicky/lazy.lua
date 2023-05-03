local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

-- require lazy safely
local status, lazy = pcall(require, "lazy")
if not status then
    return
end

-- load lazy
-- each plugin is configured by a file in the plugins/ directory and returns a configuration that lazy uses here
-- see https://github.com/folke/lazy.nvim#-structuring-your-plugins for info on how plugin-files are structured
lazy.setup("nicky.plugins")

