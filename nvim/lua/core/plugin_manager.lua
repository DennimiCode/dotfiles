-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  -- Configure any other settings here. See the documentation for more details.
  -- Lualine - blazing fast and easy to configure Neovim statusline written in Lua.
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- Neo-tree - Neovim plugin to browse the file system and other tree like structures in whatever style suits you,
  -- including sidebars, floating windows, netrw split style, or all of them at once!
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",
    },
  },
  -- Bufferline - A snazzy 💅 buffer line (with tabpage integration) for Neovim built using lua.
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  -- OneDark - Atom's iconic One Dark theme for Neovim.
  { "navarasu/onedark.nvim" },
  -- Mason - Portable package manager for Neovim that runs everywhere Neovim runs.
  -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
  { "williamboman/mason.nvim" },
  -- Mason LSP config - mason-lspconfig bridges mason.nvim with the lspconfig plugin -
  -- making it easier to use both plugins together.
  { "williamboman/mason-lspconfig.nvim" },
  -- NeoVim LSP config - configs for the Nvim LSP client
  { "neovim/nvim-lspconfig" },
  -- Nvim-dap -
  { "mfussenegger/nvim-dap" },
  -- Mason nvim dap -
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
  },
  -- None-ls - null-ls Reloaded, maintained by the community.
  { "nvimtools/none-ls.nvim" },
  -- Mason-null-ls - mason-null-ls.nvim closes some gaps that exist between mason.nvim and null-ls.
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
  },
  -- Treesitter - Treesitter configurations and abstraction layer for Neovim.
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  -- Nvim-autopairs - super powerful autopair plugin for Neovim that supports multiple characters.
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  -- LuaSnip - snippet manager written in Lua.
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  -- Nvim-cmp - completion engine plugin for neovim written in Lua.
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  -- LSPSaga - improve lsp experences in NeoVim.
  { "nvimdev/lspsaga.nvim" },
  -- Gitsigns - super fast git decorations implemented purely in Lua.
  { "lewis6991/gitsigns.nvim" },
  -- Colorizer - high-performance color highlighter for Neovim which has no external dependencies! Written in performant Luajit.
  { "norcalli/nvim-colorizer.lua" },
  -- Better-escape - this plugin is the lua version of better_escape.vim, with some additional features and optimizations.
  { "max397574/better-escape.nvim" },
  -- Comment.nvim - smart and Powerful commenting plugin for neovim
  { "numToStr/Comment.nvim" },
  -- Noice - highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  -- Dashboard-nvim - fancy and Blazing Fast start screen plugin of neovim.
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "MaximilianLloyd/ascii.nvim",
      "MunifTanjim/nui.nvim",
    },
  },
  -- Dressing - improves design and user interface of NeoVim.
  { "stevearc/dressing.nvim" },
  -- Nvim-Java - easiest way to configure NeoVim for Java delopment.
  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-refactor",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
    },
  },
  -- Which-key - WhichKey is a lua plugin for Neovim that displays a popup with possible key bindings of the command you started typing.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },
  -- Trouble - pretty list for showing diagnostics, references, telescope results, quickfix and location list
  -- to help you solve all the trouble your code is causing.
  { "folke/trouble.nvim" },
  -- Toggleterm - NeoVim plugin to persist and toggle multiple terminals during an editing session.
  { "akinsho/toggleterm.nvim", version = "*", config = true },
  -- Todo Comments - lua plugin for Neovim to highlight and search for todo comments like TODO, HACK, BUG in your code base.
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- Telescope - highly extendable fuzzy finder over lists. Built on the latest awesome features from neovim core.
  -- Telescope is centered around modularity, allowing for easy customization.
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- Telescope-ui-select - sets vim.ui.select to telescope. That means for example that neovim core stuff can fill the telescope picker.
  { "nvim-telescope/telescope-ui-select.nvim" },
  -- Trim nvim - trims trailing whitespace and lines.
  { "cappyzawa/trim.nvim" },
  -- Nvim surround - surround selections, stylishly 😎.
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
  },
  -- Rainbow delimiters - provides alternating syntax highlighting (“rainbow parentheses”) for Neovim, powered by Tree-sitter.
  { "HiPhish/rainbow-delimiters.nvim" },
  -- Auto save - is a lua plugin for automatically saving your changed buffers in Neovim.
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
  },
  -- Markdown preview - preview Markdown in your modern browser with synchronised scrolling and flexible configuration.
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  -- Diffview - single tabpage interface for easily cycling through diffs for all modified files for any git rev.
  { "sindrets/diffview.nvim" },
  -- Vim-visual-multi - it's called vim-visual-multi in analogy with visual-block, but the plugin works mostly from normal mode.
  { "mg979/vim-visual-multi" },
  -- Autotag - use treesitter to autoclose and autorename html tag.
  { "windwp/nvim-ts-autotag" },
  -- This tiny plugin adds vscode-like pictograms to neovim built-in lsp.
  {"onsails/lspkind.nvim"},
  -- Colorscheme that will be used when installing plugins.
  install = { colorscheme = { "onedark" } },
  -- Automatically check for plugin updates
  checker = { enabled = true },
})
