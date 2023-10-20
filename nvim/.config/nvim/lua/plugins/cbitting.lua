return {
  -- { "ggandor/flit.nvim", enabled = false },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  {
    "tzachar/highlight-undo.nvim",
    opts = {
      duration = 300,
      undo = {
        hlgroup = 'HighlightUndo',
        mode = 'n',
        lhs = 'u',
        map = 'undo',
        opts = {}
      },
      redo = {
        hlgroup = 'HighlightUndo',
        mode = 'n',
        lhs = '<C-r>',
        map = 'redo',
        opts = {}
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
        }
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
        }
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    setup = function()
      require('catppuccin')
      require('lualine').setup({
        options = {
          theme = "catppuccin"
        }
      })
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    config = function()
      local rt = require("rust-tools")
      rt.setup({
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-k>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      })
    end,
  },

  {
    "saecki/crates.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("null-ls")
      require("crates").setup({
        null_ls = {
          enabled = true,
          name = "crates.nvim",
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
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
      local nls = require("null-ls")
      return {
        -- nls.builtins.formatting.prettierd,
        -- nls.builtins.formatting.stylua,
        nls.builtins.diagnostics.flake8,
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "rust",
        "yaml",
        "fish"
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
