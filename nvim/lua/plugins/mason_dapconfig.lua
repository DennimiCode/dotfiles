require("mason-nvim-dap").setup({
  ensure_installed = {
    "delve",  -- Golang
    "codelldb", -- C & C++
    "coreclr", -- C# & .NET
    "javadbg", -- Java debugger
    "javatest", -- Java tests
    "kotlin", -- Kotlin
  },
  automatic_installation = true,
})
