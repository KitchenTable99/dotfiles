return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  -- Installed by default with LazyVim, but I don't like that I autocomplete hijacks my enter key
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      return {
        -- completion = {
        --   completeopt = "menu,menuone,noinsert",
        -- },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        formatting = {
          format = function(_, item)
            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      require("cmp").setup(opts)
    end,
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

  -- This is normally installed with the LazyVim extra for the Rust lang, but I hated the commented out line, so I put it in here to manage it more closely.
  {
    "simrat39/rust-tools.nvim",
    lazy = true,
    opts = function()
      local ok, mason_registry = pcall(require, "mason-registry")
      local adapter ---@type any
      if ok then
        -- rust tools configuration for debugging support
        local codelldb = mason_registry.get_package("codelldb")
        local extension_path = codelldb:get_install_path() .. "/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = ""
        if vim.loop.os_uname().sysname:find("Windows") then
          liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
        elseif vim.fn.has("mac") == 1 then
          liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
        else
          liblldb_path = extension_path .. "lldb/lib/liblldb.so"
        end
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
      end
      return {
        dap = {
          adapter = adapter,
        },
        tools = {
          on_initialized = function()
            vim.cmd([[
                augroup RustLSP
                  autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                  autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                  " autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                augroup END
              ]])
          end,
        },
      }
    end,
    config = function() end,
  },

  {
    "https://git.amazon.com/pkg/Scat-nvim",
    branch = "mainline",
    config = function()
      local map_key = vim.keymap.set
      local brazil = require("scat.brazil")
      local cr = require("scat.cr")
      local paste = require("scat.paste")
      local local_manager = require("scat.cr.local_manager")
      local brazil_utils = require("scat.brazil.utils")
      local scat = require("scat")
      scat.setup({
        cr = {
          -- template_path = vim.fn.expandcmd"$HOME/<path_to_your_cr_template>",
          user = "ccbitt",
        },
      })

      map_key("n", "<leader>al", brazil.list_all_packages, { desc = "List All Packages" })
      map_key("n", "<leader>ap", brazil.display_current_package_url, { desc = "Display Current Package URL" })
      map_key(
        "n",
        "<leader>aP",
        brazil.display_package_under_cursor_url,
        { desc = "Display URL for Package under Cursor" }
      )
      map_key(
        "n",
        "<leader>aR",
        brazil.display_release_under_cursor_url,
        { desc = "Display URL for Release under Cursor" }
      )
      map_key({ "n", "x" }, "<leader>af", brazil.display_current_file_url, { desc = "Display Current File URL" })
      map_key("n", "<leader>aij", brazil.install_current_jdt_package, { desc = "Install Current JDT Package" })
      map_key("n", "<leader>ar", cr.open_cr, { desc = "Open CR" })
      -- or map_key("n", "<leader>ar", function() cr.open_cr({ cr_template = vim.fn.expandcmd"$HOME/<path_to_your_cr_template>" }) end, { desc = "Open CR" })
      map_key("n", "<leader>arp", cr.fetch_active_crs, { desc = "Fetch Active CRs" })
      -- the below mapping prompts for user id you would like to view instead of picking from config
      map_key("n", "<leader>arpp", function()
        cr.fetch_active_crs({ force_pick = true })
      end, { desc = "Fetch Active CRs (ignore user specified in config)" })
      -- or map_key("n", "<leader>arp", function() cr.fetch_active_crs({user = "<your_user_name>"}) end)
      map_key("n", "<leader>aru", cr.update_existing_cr, { desc = "Update Existing CR" })
      map_key("n", "<leader>art", local_manager.toggle_cr_overview, { desc = "Toggle CR Overview" })
      map_key("n", "<leader>ac", brazil_utils.run_checkstyle, { desc = "Run Brazil Checkstyle" })
      map_key("n", "<leader>ab", brazil.build_current_package, { desc = "Build Current Package" })
      map_key(
        "n",
        "<leader>abc",
        brazil.run_command_inside_current_package,
        { desc = "Run Brazil Command inside Current Package" }
      )
      map_key("n", "<leader>abt", function()
        brazil.pick_brazil_task_inside_current_package({
          callback = function(task)
            vim.g.test_replacement_command = task
          end,
        })
      end, { desc = "Pick Brazil Task inside Current Package" })
      map_key("n", "<leader>abl", brazil.run_prev_brazil_task, { desc = "Run Previous Brazil Task" })
      map_key("n", "<leader>av", brazil.display_current_version_set_url, { desc = "Display Current Version Set URL" })
      map_key(
        "n",
        "<leader>abr",
        brazil.build_current_package_recursively,
        { desc = "Build Current Package Recursively" }
      )
      map_key(
        "n",
        "<leader>aw",
        brazil.switch_workspace_package_info,
        { desc = "Switch packageInfo in Current Workspace" }
      )
      map_key({ "n", "x" }, "<leader>as", paste.send_to_pastebin, { desc = "Send Selection to Pastebin" })
      map_key("n", "<leader>asl", paste.list_my_pastes, { desc = "List My Pastes" })
      -- if you are using the patched fork of Telescope, you can also leverage these, see more details below
      -- map_key('n', '<leader>ais', brazil.lookup_packages, { desc = "Lookup Packages" })
      -- map_key('n', '<leader>aiv', brazil.lookup_version_set, { desc = "Lookup Version Set" })
    end,
    requires = { "nvim-telescope/telescope.nvim", "sindrets/diffview.nvim" },
  },

  -- {
  --   "m4xshen/hardtime.nvim",
  --   event = "VeryLazy",
  --   opts = {}
  -- },

  {
    "nvim-telescope/telescope-bibtex.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>aa", "<cmd>Telescope bibtex format=autocite<cr>",   desc = "Insert autocite" },
      { "<leader>as", "<cmd>Telescope bibtex format=additional<cr>", desc = "Insert additional citation" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        extensions = {
          bibtex = {
            -- Custom format for citation label
            custom_formats = {
              { id = "autocite",   cite_marker = "\\autocite{%s}" },
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

  { "jose-elias-alvarez/typescript.nvim" },

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
    url = "ccbitt@git.amazon.com:pkg/NinjaHooks",
    lazy = false,
    branch = "mainline",
    config = function(plugin)
      vim.opt.rtp:prepend(plugin.dir .. "/configuration/vim/amazon/brazil-config")
      -- Make my own filetype thing to override neovim applying ".conf" file type.
      -- You may or may not need this depending on your setup.
      vim.filetype.add({
        filename = {
          ["Config"] = function()
            vim.b.brazil_package_Config = 1
            return "brazilconfig"
          end,
        },
      })
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
    ---@class PluginLpsOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },
}
