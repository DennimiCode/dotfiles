require("mason-nvim-dap").setup({
  ensure_installed = {
    "python",
    "delve",
    "coreclr",
    "codelldb",
    "javadbg",
    "kotlin",
  },
  automatic_installation = true,
})
