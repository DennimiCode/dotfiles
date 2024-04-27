local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.completion.spell,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.formatting.sqlfmt,
    null_ls.builtins.formatting.google_java_format,
    null_ls.builtins.formatting.csharpier,
  },
})
