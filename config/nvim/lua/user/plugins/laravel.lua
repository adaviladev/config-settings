return {
  "adalessa/laravel.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "tpope/vim-dotenv",
    "MunifTanjim/nui.nvim",
  },
  cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
  keys = {
    { "<leader>La", ":Laravel artisan<cr>" },
    { "<leader>Lr", ":Laravel routes<cr>" },
    { "<leader>Lm", ":Laravel related<cr>" },
    {
      "<leader>Lt",
      function()
        require("laravel.tinker").send_to_tinker()
      end,
      mode = "v",
      desc = "Laravel Application Routes",
    },
  },
  event = { "VeryLazy" },
  config = function()
    require("laravel").setup()
    require("telescope").load_extension "laravel"
  end,
}
