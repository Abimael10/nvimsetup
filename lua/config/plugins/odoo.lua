return {
  {
    "odoo/odoo-neovim",
    ft = { "python", "xml" },
    config = function()
      local server = vim.fn.expand("$HOME/.local/share/nvim/odoo/odoo_ls_server")
      if vim.fn.executable(server) ~= 1 then
        vim.notify(
          "odoo_ls_server not found at " .. server .. "\n"
            .. "Download from: https://github.com/odoo/odoo-ls/releases",
          vim.log.levels.WARN
        )
        return
      end

      vim.lsp.config("odoo_ls", {
        cmd = { server },
        filetypes = { "python", "xml" },
        root_dir = vim.fs.dirname(
          vim.fs.find({ "odools.toml", ".git" }, { path = vim.fn.getcwd(), upward = true })[1]
        ),
        settings = {
          Odoo = {
            selectedProfile = "main",
          },
        },
      })

      vim.lsp.enable("odoo_ls")
    end,
  },
}
