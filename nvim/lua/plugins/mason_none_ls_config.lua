require("mason-null-ls").setup({
  ensure_installed = {
    "stylua",
    "clang_format",
    "csharpier",
    "google-java-format",
    "sqlfmt",
    "hadolint",
    "cspell",
  },
  automatic_installation = true,
})
