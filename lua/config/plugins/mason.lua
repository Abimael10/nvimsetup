local registry = require("mason-registry")

local function extend(target, items)
  target.ensure_installed = target.ensure_installed or {}
  for _, item in ipairs(items) do
    local ok = registry.has_package(item)
    if ok and not vim.tbl_contains(target.ensure_installed, item) then
      table.insert(target.ensure_installed, item)
    end
  end
end

local servers = {
  "angularls",
  "ansiblels",
  "astro",
  "bashls",
  "clangd",
  "cmake",
  "cssls",
  "dockerls",
  "elmls",
  "elixirls",
  "emmet_ls",
  "eslint",
  "gopls",
  "graphql",
  "hls",
  "html",
  "jsonls",
  "kotlin_language_server",
  "lemminx",
  "lua_ls",
  "marksman",
  "metals",
  "nixd",
  "omnisharp",
  "prismals",
  "pyright",
  "ruff",
  "rust_analyzer",
  "sqlls",
  "svelte",
  "tailwindcss",
  "taplo",
  "terraformls",
  "texlab",
  "tsserver",
  "volar",
  "yamlls",
  "zls",
}

local tools = {
  "black",
  "codelldb",
  "debugpy",
  "eslint_d",
  "gofumpt",
  "goimports",
  "hadolint",
  "isort",
  "prettier",
  "ruff",
  "shellcheck",
  "shfmt",
  "sqlfluff",
  "stylua",
  "taplo",
  "terraform-ls",
  "yamllint",
}

return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      return opts or {}
    end,
    config = function(_, opts)
      require("mason").setup(opts)

      local mason_health = require("mason.health")
      if mason_health._nv_language_filter then
        return
      end
      mason_health._nv_language_filter = true

      local health_check = mason_health.check
      local upvalue_lookup = {}
      for i = 1, 32 do
        local name, value = debug.getupvalue(health_check, i)
        if not name then
          break
        end
        upvalue_lookup[name] = { index = i, value = value }
      end

      local check_languages_info = upvalue_lookup.check_languages
      if not check_languages_info then
        return
      end

      local original_check_languages = check_languages_info.value
      local inner_lookup = {}
      for i = 1, 32 do
        local name, value = debug.getupvalue(original_check_languages, i)
        if not name then
          break
        end
        inner_lookup[name] = value
      end

      local report_start = inner_lookup.report_start or upvalue_lookup.report_start.value
      local async_mod = inner_lookup.a or upvalue_lookup.a.value
      local check_thunk = inner_lookup.check_thunk
      local check_fn = inner_lookup.check
      local platform = inner_lookup.platform

      if not (report_start and async_mod and check_thunk and check_fn and platform) then
        return
      end

      local filtered_check_languages = function()
        report_start "mason.nvim [Languages]"
        async_mod.wait_all {
          check_thunk {
            cmd = "go",
            args = { "version" },
            name = "Go",
            relaxed = true,
            version_check = function(version)
              local _, _, major, minor = version:find "go(%d+)%.(%d+)"
              if not (tonumber(major) >= 1 and tonumber(minor) >= 17) then
                return "Go version must be >= 1.17."
              end
            end,
          },
          check_thunk {
            cmd = "cargo",
            args = { "--version" },
            name = "cargo",
            relaxed = true,
            version_check = function(version)
              local _, _, major, minor = version:find "(%d+)%.(%d+)%.(%d+)"
              if (tonumber(major) <= 1) and (tonumber(minor) < 60) then
                return "Some cargo installations require Rust >= 1.60.0."
              end
            end,
          },
          check_thunk {
            cmd = "luarocks",
            args = { "--version" },
            name = "luarocks",
            relaxed = true,
            version_check = function(version)
              local _, _, major = version:find "(%d+)%.(%d+)%.(%d+)"
              if not (tonumber(major) >= 3) then
                return "Luarocks version must be >= 3.0.0."
              end
            end,
          },
          check_thunk {
            cmd = "npm",
            args = { "--version" },
            name = "npm",
            relaxed = true,
            version_check = function(version)
              local _, _, major = version:find "(%d+)%.(%d+)%.(%d+)"
              if tonumber(major) < 7 then
                return "npm version must be >= 7"
              end
            end,
          },
          check_thunk {
            cmd = "node",
            args = { "--version" },
            name = "node",
            relaxed = true,
            version_check = function(version)
              local _, _, major = version:find "v(%d+)%.(%d+)%.(%d+)"
              if tonumber(major) < 14 then
                return "Node version must be >= 14"
              end
            end,
          },
          function()
            local python = platform.is.win and "python" or "python3"
            check_fn { cmd = python, args = { "--version" }, name = "python", relaxed = true }
            check_fn { cmd = python, args = { "-m", "pip", "--version" }, name = "pip", relaxed = true }
            check_fn {
              cmd = python,
              args = { "-c", "import venv" },
              name = "python venv",
              relaxed = true,
              advice = {
                [[On Debian/Ubuntu systems, you need to install the python3-venv package using the following command:

apt-get install python3-venv]],
              },
            }
          end,
        }
      end

      debug.setupvalue(health_check, check_languages_info.index, filtered_check_languages)
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      extend(opts, servers)
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      extend(opts, servers)
      extend(opts, tools)
    end,
  },
}
