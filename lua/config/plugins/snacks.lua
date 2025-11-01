return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        diagnostics = {
          enabled = true,
        },
      },
      image = {
        enabled = true,
        doc = {
          inline = true,
          float = true,
        },
      },
    },
    config = function(_, opts)
      local Snacks = require("snacks")
      Snacks.setup(opts or {})

      local diagnostics = require("snacks.explorer.diagnostics")
      local original_update = diagnostics.update

      diagnostics.update = function(...)
        local ok, result = pcall(original_update, ...)
        if not ok then
          local message = tostring(result)
          if message:match("Invalid buffer id") then
            return false
          end
          error(result)
        end
        return result
      end
    end,
  },
}
