local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

local opt = vim.opt
opt.number = true
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.ambiwidth = 'double'

opt.autoindent = true
opt.smartindent = true
opt.cursorline = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.relativenumber = true
opt.termguicolors = true


require("config.lazy")
