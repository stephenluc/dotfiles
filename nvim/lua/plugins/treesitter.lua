return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter",
    opts = {
      ensure_installed = {
        "typescript", "javascript", "tsx",
        "json", "lua", "markdown", "bash",
        "terraform", "vim", "vimdoc",
      },
    },
  },
}
