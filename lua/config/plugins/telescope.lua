return {
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>fh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Help tags",
      },
      {
        "<leader>fd",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find directory",
      },
      {
        "<leader>en",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Open Neovim config",
      },
    },
  },
}
