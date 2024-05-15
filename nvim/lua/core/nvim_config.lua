vim.g.did_load_filetypes = 1
vim.g.formatoptions = "qrn1"
vim.opt.showmode = false
vim.opt.updatetime = 100
vim.wo.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.wo.linebreak = true
vim.opt.virtualedit = "block"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.encoding = "utf-8"
vim.opt.termguicolors = true
vim.opt.colorcolumn = "120"
vim.opt.cursorline = true
vim.cmd("hi colorcolumn guibg=#F4935B")
vim.notify = require("notify")

if os.getenv("HOME") == nil then
	vim.cmd([[
    set shell=pwsh
    set shellcmdflag=-command
    set shellquote=\"
    set shellxquote=
]])
else
	vim.o.shell = vim.o.shell
end

-- Mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.wo.number = true
vim.wo.relativenumber = true

-- Indent Settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

-- Python indent setup
vim.api.nvim_create_autocmd("FileType", {
	pattern = "py",
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.colorcolumn = "80"
	end,
})

-- GO indent setup
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
	end,
})

-- C# Lang indent setup
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cs",
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
	end,
})

-- Rust indent setup
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rs",
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
	end,
})

vim.cmd([[highlight clear LineNr]])
vim.cmd([[highlight clear SignColumn]])
