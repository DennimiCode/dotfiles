-- The builtin filetype detection provided by Nvim
vim.g.did_load_filetypes = 1
-- Disable showmode
vim.opt.showmode = false
-- Set updatetime to 100 ms
vim.opt.updatetime = 100
-- When signs are defined for a file, Vim will automatically add a column of two
-- characters to display them in.  When the last sign is unplaced the column disappears again.
vim.wo.signcolumn = "yes"
-- Faster scroll
vim.opt.scrolloff = 8
-- Disable wrapping
vim.opt.wrap = false
-- Enable line breaking
vim.wo.linebreak = true
-- Virtual editing means that the cursor can be positioned where there is
-- no actual character.  This can be halfway into a tab or beyond the end of the line.
vim.opt.virtualedit = "block"
-- Enable undo file
vim.opt.undofile = true
-- Disable swap file
vim.opt.swapfile = false
-- Set default buffer encoding as UTF-8
vim.opt.encoding = "utf-8"
-- Enable 24 bit colors in terminal
vim.opt.termguicolors = true
-- Enable color column on 120 length
vim.opt.colorcolumn = "120"
-- Enable highlighting the line with cursor
vim.opt.cursorline = true
-- Setup colorcolumn color
vim.cmd("hi colorcolumn guibg=#F4935B")
-- Enable modern notifications
vim.notify = require("notify")

-- Select shell type based on your OS (For windows: PowerShell NEW, for other: your default shell)
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

-- Enable mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Sync clipboard with OS
vim.opt.clipboard = "unnamedplus"

-- Setup line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.wo.number = true
vim.wo.relativenumber = true

-- Default indent Settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

-- Setup indent exceptions
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
