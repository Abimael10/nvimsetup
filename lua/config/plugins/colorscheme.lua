local scheme_presets = {
  { name = "Tokyo Night · Night", colorscheme = "tokyonight-night" },
  { name = "Tokyo Night · Storm", colorscheme = "tokyonight-storm" },
  { name = "Catppuccin · Mocha", colorscheme = "catppuccin-mocha" },
  { name = "GitHub · Dark Dimmed", colorscheme = "github_dark_dimmed" },
  { name = "Nightfox · Carbon", colorscheme = "carbonfox" },
  { name = "Gruvbox · Dark Hard", colorscheme = "gruvbox" },
  { name = "OneDark · Darker", colorscheme = "onedark" },
  { name = "Kanagawa · Dragon", colorscheme = "kanagawa-dragon" },
  { name = "Kanagawa · Wave", colorscheme = "kanagawa-wave" },
  { name = "Everforest · Dark", colorscheme = "everforest" },
  { name = "Rose Pine · Moon", colorscheme = "rose-pine-moon" },
  { name = "Dracula", colorscheme = "dracula" },
  { name = "Nord", colorscheme = "nord" },
  { name = "Oxocarbon", colorscheme = "oxocarbon" },
  { name = "OneDark Pro", colorscheme = "onedarkpro" },
  { name = "Gruvbox Material", colorscheme = "gruvbox-material" },
  { name = "Sonokai", colorscheme = "sonokai" },
  { name = "Material · Deep Ocean", colorscheme = "material" },
  { name = "Monokai Pro", colorscheme = "monokai-pro" },
  { name = "Moonfly", colorscheme = "moonfly" },
  { name = "Nightfly", colorscheme = "nightfly" },
}

local function register_selector()
  pcall(vim.api.nvim_del_user_command, "ColorschemeSelect")

  vim.api.nvim_create_user_command("ColorschemeSelect", function()
    vim.ui.select(
      scheme_presets,
      {
        prompt = "Select colorscheme",
        format_item = function(item)
          return item.name
        end,
      },
      function(choice)
        if not choice then
          return
        end
        vim.schedule(function()
          vim.cmd.colorscheme(choice.colorscheme)
        end)
      end
    )
  end, {})

  vim.keymap.set("n", "<leader>uc", "<cmd>ColorschemeSelect<cr>", {
    desc = "Select colorscheme",
    noremap = true,
    silent = true,
  })
end

return {
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      opts.colorscheme = "tokyonight-night"
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      light_style = "day",
      dim_inactive = true,
      lualine_bold = true,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      register_selector()
      vim.schedule(function()
        vim.cmd.colorscheme("tokyonight-night")
      end)
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = true,
    opts = {
      flavour = "mocha",
      background = { light = "latte", dark = "mocha" },
      integrations = {
        cmp = true,
        gitsigns = true,
        telescope = { enabled = true },
        treesitter = true,
        which_key = true,
        noice = true,
        mini = true,
        markdown = true,
      },
    },
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    priority = 1000,
    lazy = true,
    opts = {
      options = {
        terminal_colors = true,
        hide_end_of_buffer = true,
        module_default = true,
        dim_inactive = false,
      },
    },
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    lazy = true,
    opts = {
      options = {
        transparent = false,
        terminal_colors = true,
        dim_inactive = false,
      },
    },
    config = function(_, opts)
      require("nightfox").setup(opts)
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = true,
    opts = {
      contrast = "hard",
      palette_overrides = {},
      transparent_mode = false,
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
    end,
  },
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    lazy = true,
    opts = {
      style = "darker",
      transparent = false,
      lualine = {
        transparent = false,
      },
    },
    config = function(_, opts)
      require("onedark").setup(opts)
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = true,
    opts = {
      compile = false,
      dimInactive = true,
      theme = "wave",
      background = {
        dark = "dragon",
        light = "lotus",
      },
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
    end,
  },
  {
    "neanias/everforest-nvim",
    priority = 1000,
    lazy = true,
    version = false,
    opts = {
      background = "hard",
      transparent_background_level = 0,
      italics = true,
      float_style = "dim",
    },
    config = function(_, opts)
      require("everforest").setup(opts)
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    lazy = true,
    opts = {
      variant = "moon",
      extend_background_behind_borders = true,
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
    end,
  },
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    lazy = true,
    opts = {
      italic_comment = true,
      overrides = {},
    },
    config = function(_, opts)
      require("dracula").setup(opts)
    end,
  },
  {
    "shaunsingh/nord.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
    priority = 1000,
    init = function()
      vim.opt.background = "dark"
    end,
  },
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      options = { cursorline = true },
    },
    config = function(_, opts)
      require("onedarkpro").setup(opts)
    end,
  },
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    priority = 1000,
    init = function()
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_better_performance = 1
    end,
  },
  {
    "sainnhe/sonokai",
    lazy = true,
    priority = 1000,
    init = function()
      vim.g.sonokai_style = "default"
      vim.g.sonokai_better_performance = 1
    end,
  },
  {
    "marko-cerovac/material.nvim",
    lazy = true,
    priority = 1000,
    init = function()
      vim.g.material_style = "deep ocean"
    end,
  },
  {
    "loctvl842/monokai-pro.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      transparent_background = false,
      filter = "pro",
    },
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = true,
    priority = 1000,
  },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = true,
    priority = 1000,
  },
}
