-- Set space as <leader> key
vim.g.mapleader = " "

-- Main keymaps
-- Save changes in current buffer
vim.keymap.set("n", "<leader>w", ":w<CR>", { silent = true })
-- Save changes in all opended buffers
vim.keymap.set("n", "<leader>wa", ":wa<CR>", { silent = true })
-- Close current buffer
vim.keymap.set("n", "<leader>q", ":q<CR>", { silent = true })
-- Fast exit from INSERT mode by pressing jj
vim.keymap.set("i", "jj", "<ESC>", { silent = true })
-- Clear highlighting after search
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { silent = true })

-- Window navigation on hjkl
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { silent = true })
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { silent = true })

-- Buffer splits keymap
vim.keymap.set("n", "|", ":vsplit<CR>", { silent = true })
vim.keymap.set("n", "\\", ":split<CR>", { silent = true })

-- LSP
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true })
vim.keymap.set("n", "<leader>lD", vim.diagnostic.open_float, { silent = true })
vim.keymap.set("n", "<leader>ll", vim.diagnostic.setloclist, { silent = true })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { silent = true })
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { silent = true })
vim.keymap.set("n", "<leader>lk", vim.lsp.buf.hover, { silent = true })
vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { silent = true })
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { silent = true })

-- Debuggin
vim.keymap.set("n", "<leader>dt", ":DapToggleBreakpoint<CR>", { silent = true })
vim.keymap.set("n", "<leader>dx", ":DapTerminate<CR>", { silent = true })
vim.keymap.set("n", "<leader>do", ":DapStepOver<CR>", { silent = true })
vim.keymap.set("n", "<leader>dl", ":lua require'dap'.run_last()<CR>", { silent = true })
vim.keymap.set("n", "<leader>dc", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<leader>lp", "lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<S-F5>", ":lua require'dap'.close()<CR>")
vim.keymap.set("n", "<C-S-F5>", ":lua require'dap'.restart()<CR>")
vim.keymap.set("n", "<F10>", ":lua require'dap'.step_over()<CR>", { silent = true })
vim.keymap.set("n", "<F11>", ":lua require'dap'.step_into()<CR>", { silent = true })
vim.keymap.set("n", "<F12>", ":lua require'dap'.step_out()<CR>", { silent = true })

-- NeoTree
vim.keymap.set("n", "<leader>e", ":Neotree toggle float focus<CR>", { silent = true })
vim.keymap.set("n", "<leader>E", ":Neotree toggle float reveal <CR>", { silent = true })

-- Bufferline
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })
vim.keymap.set("n", "<leader>x", ":BufferLinePickClose<CR>", { silent = true })
vim.keymap.set("n", "<leader>X", ":BufferLineCloseRight<CR>", { silent = true })
vim.keymap.set("n", "<leader>s", ":BufferLineSortByTabs<CR>", { silent = true })

-- Trouble
vim.keymap.set("n", "<leader>tx", function() require("trouble").toggle() end, { silent = true })
vim.keymap.set("n", "<leader>tw", function() require("trouble").toggle("workspace_diagnostics") end, { silent = true })
vim.keymap.set("n", "<leader>td", function() require("trouble").toggle("document_diagnostics") end, { silent = true })
vim.keymap.set("n", "<leader>tq", function() require("trouble").toggle("quickfix") end, { silent = true })
vim.keymap.set("n", "<leader>tl", function() require("trouble").toggle("loclist") end, { silent = true })

-- Git
vim.keymap.set('n', '<leader>gd', ":DiffviewOpen<CR>", { silent = true })
vim.keymap.set('n', '<leader>gf', ":DiffviewClose<CR>", { silent = true })
vim.keymap.set("n", "<leader>gs", ":Neotree toggle float git_status<CR>", { silent = true })
