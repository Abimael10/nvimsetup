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
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Grep (live, regex)",
      },
      {
        "<leader>fw",
        function()
          require("telescope.builtin").grep_string()
        end,
        desc = "Grep word under cursor",
      },
      {
        "<leader>fw",
        function()
          require("telescope.builtin").grep_string()
        end,
        mode = "v",
        desc = "Grep selection",
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
