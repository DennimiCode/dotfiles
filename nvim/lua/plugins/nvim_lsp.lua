local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.csharp_ls.setup({ capabilities = capabilities })              -- C#
lspconfig.lua_ls.setup({ capabilities = capabilities })                 -- Lua
lspconfig.clangd.setup({ capabilities = capabilities })                 -- C & C++
lspconfig.gopls.setup({ capabilities = capabilities })                  -- Golang
lspconfig.tsserver.setup({ capabilities = capabilities })               -- JavaScript & TypeScript
lspconfig.jdtls.setup({ capabilities = capabilities })                  -- Java
lspconfig.gradle_ls.setup({ capabilities = capabilities })              -- Gradle
lspconfig.kotlin_language_server.setup({ capabilities = capabilities }) -- Kotlin
lspconfig.bashls.setup({ capabilities = capabilities })                 -- Bash
lspconfig.powershell_es.setup({ capabilities = capabilities })          -- PowerShell
lspconfig.dockerls.setup({ capabilities = capabilities })               -- Docker
lspconfig.html.setup({ capabilities = capabilities })                   -- HTML
lspconfig.cssls.setup({ capabilities = capabilities })                  -- CSS
lspconfig.jsonls.setup({ capabilities = capabilities })                 -- JSON
lspconfig.yamlls.setup({ capabilities = capabilities })                 -- YAML
lspconfig.taplo.setup({ capabilities = capabilities })                  -- TOML
lspconfig.lemminx.setup({ capabilities = capabilities })                -- XML
lspconfig.marksman.setup({ capabilities = capabilities })               -- Markdown
lspconfig.sqls.setup({
  on_attach = function(client, bufnr)
    require("sqls").on_attach(client, bufnr)
  end,
})
