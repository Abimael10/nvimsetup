return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      direction = "float",
      size = 50,
      open_mapping = [[<c-\>]],
    },
    config = function(_, opts)
      local toggleterm = require("toggleterm")
      toggleterm.setup(opts)

      vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Exit terminal mode" })

      local Terminal = require("toggleterm.terminal").Terminal
      local float_term

      local function toggle_float()
        float_term = float_term or Terminal:new({ direction = "float", hidden = true })
        float_term:toggle()
      end

      vim.api.nvim_create_user_command("Floaterminal", toggle_float, { desc = "Toggle floating terminal" })
      vim.keymap.set({ "n", "t" }, "<leader>tt", toggle_float, { desc = "Toggle floating terminal" })

      vim.api.nvim_create_user_command("ToggleServe", function()
        local file = vim.fn.expand("%:p")
        if file == "" then
          vim.notify("No file to serve", vim.log.levels.WARN)
          return
        end
        toggleterm.exec("live-server " .. file, 80, 12)
      end, { desc = "Run live-server for current file" })
    end,
  },
}
