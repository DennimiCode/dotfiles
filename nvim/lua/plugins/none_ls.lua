local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua, -- Lua
    null_ls.builtins.completion.spell, -- Spelling
    null_ls.builtins.formatting.clang_format, -- C & C++, Objective-C and etc. in CLang
    null_ls.builtins.formatting.gofmt, -- Golang
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.formatting.sqlfmt, -- SQL formatter
    null_ls.builtins.formatting.google_java_format, -- Java formatter with Google rules
    null_ls.builtins.formatting.csharpier, -- C# formatter
  },
})
