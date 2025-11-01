return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    opts = function(_, opts)
      local blink_caps = require("blink.cmp").get_lsp_capabilities()
      opts.servers = opts.servers or {}
      opts.servers["*"] = opts.servers["*"] or {}
      opts.servers["*"].capabilities = vim.tbl_deep_extend(
        "force",
        opts.servers["*"].capabilities or {},
        blink_caps
      )
    end,
  },
}
