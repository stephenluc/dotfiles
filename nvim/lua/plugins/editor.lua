return {
  { "tpope/vim-surround" },
  { "tpope/vim-commentary" },
  { "tpope/vim-repeat" },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  { "christoomey/vim-tmux-navigator" },
  { "tpope/vim-sleuth" },
}
