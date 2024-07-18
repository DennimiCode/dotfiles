require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",               -- Lua
    "clangd",               -- C & C++
    "csharp_ls",            -- C#
    "gopls",                -- Golang
    "tsserver",             -- JavaScript & TypeScript
    "html",                 -- HTML
    "cssls",                -- CSS
    "somesass_ls",          -- Sass
    "lemminx",              -- XML
    "taplo",                -- TOML
    "yamlls",               -- YAML
    "jsonls",               -- JSON
    "marksman",             -- Markdown
    "jdtls",                -- Java
    "gradle_ls",            -- Gradle
    "kotlin_language_server", -- Kotlin
    "sqls",                 -- SQL
    "bashls",               -- Bash
    "powershell_es",        -- PowerShell
    "dockerls",             -- Docker
  },
  automatic_installation = true,
})
