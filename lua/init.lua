-- basic
-- 显示相对行号
vim.opt.relativenumber = true
-- 开启真彩色
vim.opt.termguicolors  = true
vim.opt.tabstop        = 2


require("configs.treesitter").config()
require("configs.telescope").config()
