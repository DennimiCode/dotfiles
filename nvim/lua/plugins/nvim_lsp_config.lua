local lspconfig = require("lspconfig")
local pid = vim.fn.getpid()
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local omnisharp_bin = ""

if os.getenv("SHELL") == nil then
	omnisharp_bin = vim.fn.expand("$HOME/AppData/Local/omnisharp-vim/omnisharp-roslyn/OmniSharp.exe")
else
	omnisharp_bin = vim.fn.expand("~/.cache/omnisharp-vim/omnisharp-roslyn/OmniSharp")
end

lspconfig.lua_ls.setup({ capabilities = capabilities })
lspconfig.pyright.setup({ capabilities = capabilities })
lspconfig.clangd.setup({ capabilities = capabilities })
lspconfig.arduino_language_server.setup({ capabilities = capabilities })
lspconfig.taplo.setup({ capabilities = capabilities })
lspconfig.gopls.setup({ capabilities = capabilities })
lspconfig.tsserver.setup({ capabilities = capabilities })
lspconfig.jdtls.setup({ capabilities = capabilities })
lspconfig.gradle_ls.setup({ capabilities = capabilities })
lspconfig.bashls.setup({ capabilities = capabilities })
lspconfig.powershell_es.setup({ capabilities = capabilities })
lspconfig.dockerls.setup({ capabilities = capabilities })
lspconfig.html.setup({ capabilities = capabilities })
lspconfig.cssls.setup({ capabilities = capabilities })
lspconfig.jsonls.setup({ capabilities = capabilities })
lspconfig.yamlls.setup({ capabilities = capabilities })
lspconfig.marksman.setup({ capabilities = capabilities })
lspconfig.lemminx.setup({ capabilities = capabilities })
lspconfig.kotlin_language_server.setup({ capabilities = capabilities })
-- TODO: Enable sqls language server, when they fix Golang errors
lspconfig.sqls.setup({
	on_attach = function(client, bufnr)
		require("sqls").on_attach(client, bufnr)
	end,
	capabilities = capabilities,
	settings = {
		sqls = {
			connections = {
				{
					driver = "mysql",
					dataSourceName = "root:@2z^5#CgYqJAqH@tcp(127.0.0.1:3306)/test",
				},
				{
					driver = "postgresql",
					dataSourceName = "host=127.0.0.1 port=5432 user=postgres password=u#bK6Vp@D!8@8z "
						.. " sslmode=disable",
				},
				{
					driver = "mssql",
					dataSourceName = "sqlserver://ExternalAdminUser:1234567890@localhost/SQLEXPRESS?database=test",
				},
			},
		},
	},
})
lspconfig.rust_analyzer.setup({
	on_attach = function(client)
		require("completion").on_attach(client)
	end,
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				nable = true,
			},
		},
	},
})
lspconfig.omnisharp.setup({
	on_attach = function(client)
		require("completion").on_attach(client)
	end,
	capabilities = capabilities,
	OmniSharp_server_use_net6 = 1,
	OmniSharp_highlighting = 3,
	cmd = {
		omnisharp_bin,
		"--languageserver",
		"--hostPID",
		tostring(pid),
	},
})
