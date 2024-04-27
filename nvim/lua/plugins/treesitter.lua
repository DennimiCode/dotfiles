require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
    "luadoc",
    "vim",
    "vimdoc",
    "query",
    "python",
    "c",
    "cpp",
    "arduino",
    "rust",
    "toml",
    "c_sharp",
    "go",
    "gomod",
    "java",
    "groovy",
    "kotlin",
    "markdown",
    "markdown_inline",
    "javascript",
    "jsdoc",
    "typescript",
    "tsx",
    "html",
    "css",
    "scss",
    "sql",
    "bash",
    "http",
    "dockerfile",
    "yaml",
    "xml",
    "json",
    "json5",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  autotag = {
    enable = true,
  },
})
