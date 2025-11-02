return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters = opts.linters or {}
      local uv = vim.uv or vim.loop

      local sqlfluff_condition = function(ctx)
        local config_files = {
          ".sqlfluff",
          ".sqlfluffrc",
          ".sqlfluffrc.json",
          ".sqlfluffrc.toml",
          ".sqlfluffrc.yaml",
          ".sqlfluffrc.yml",
          ".sqlfluff.ini",
          "pyproject.toml",
          "setup.cfg",
        }
        local found = vim.fs.find(config_files, {
          path = ctx.dirname or ctx.filename,
          upward = true,
        })[1]
        if found then
          return true
        end
        local env_config = vim.env.SQLFLUFF_CONFIG
        return env_config and uv.fs_stat(env_config) ~= nil
      end

      opts.linters.sqlfluff = vim.tbl_deep_extend("force", opts.linters.sqlfluff or {}, {
        condition = sqlfluff_condition,
      })
    end,
  },
}
