return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    },
  },

  {
    "tzachar/highlight-undo.nvim",
    opts = {
      duration = 300,
      undo = {
        hlgroup = "HighlightUndo",
        mode = "n",
        lhs = "u",
        map = "undo",
        opts = {},
      },
      redo = {
        hlgroup = "HighlightUndo",
        mode = "n",
        lhs = "<C-r>",
        map = "redo",
        opts = {},
      },
      highlight_for_count = true,
    },
  },

  { "sindrets/diffview.nvim" },

  -- {
  --   "m4xshen/hardtime.nvim",
  --   event = "VeryLazy",
  --   opts = {}
  -- },

  {
    "nvim-telescope/telescope-bibtex.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>aa", "<cmd>Telescope bibtex format=autocite<cr>", desc = "Insert autocite" },
      { "<leader>as", "<cmd>Telescope bibtex format=additional<cr>", desc = "Insert additional citation" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        extensions = {
          bibtex = {
            -- Custom format for citation label
            custom_formats = {
              { id = "autocite", cite_marker = "\\autocite{%s}" },
              { id = "additional", cite_marker = ", %s" },
            },
          },
        },
      })
      telescope.load_extension("bibtex")
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "frappe", -- latte, frappe, macchiato, mocha
        integrations = {
          which_key = true,
          leap = true,
          telescope = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
          navic = {
            enabled = false,
            custom_bg = "NONE",
          },
        },
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    setup = function()
      require("catppuccin")
      require("lualine").setup({
        options = {
          theme = "catppuccin",
        },
      })
    end,
  },

  { "christoomey/vim-tmux-navigator" },

  { "nvim-treesitter/nvim-treesitter-context" },

  {
    "lervag/vimtex",
    module = false,
    -- config in options.lua
  },

  {
    "andrewferrier/wrapping.nvim",
    config = function()
      require("wrapping").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "lua",
        "fish",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },
}
