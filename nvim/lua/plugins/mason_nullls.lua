require("mason-null-ls").setup({
  ensure_installed = {
    "stylua",           -- Lua formatter
    "clang_format",     -- C & C++ formatter
    "csharpier",        -- C# formatter
    "google-java-format", -- Java formatter with Google rules
    "sqlfmt",           -- SQL formatter
    "hadolint",
    "cspell",
    "goimports", -- Organize imports for Golang
  },
  automatic_installation = true,
})
