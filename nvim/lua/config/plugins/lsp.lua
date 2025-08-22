return {
  -- Mason core
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason ↔ LSP bridge
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "ts_ls",      -- keep what you're using
          "tailwindcss",
          "html",
          "cssls",
          "pyright",
          "clangd",
          "sqls",
          "prismals",
        },
      }
    end,
  },

  -- rust-tools (manages rust-analyzer for us)
  {
    "simrat39/rust-tools.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local rt = require("rust-tools")

      -- Reuse the same on_attach across servers
      local on_attach = function(_, bufnr)
        -- Basics
        vim.keymap.set("n", "K",  vim.lsp.buf.hover,        { buffer = bufnr })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration,  { buffer = bufnr })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition,   { buffer = bufnr })
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = bufnr })
        vim.keymap.set("n", "jk", vim.lsp.buf.format,       { buffer = bufnr })

        -- rust-tools extras
        vim.keymap.set("n", "<leader>rh", rt.hover_actions.hover_actions, { buffer = bufnr, desc = "Rust Hover Actions" })
        vim.keymap.set("n", "<leader>ra", rt.code_action_group.code_action_group, { buffer = bufnr, desc = "Rust Code Action Group" })
      end

      -- Toggle inlay hints: <leader>ih
      vim.keymap.set("n", "<leader>ih", function()
        local buf = vim.api.nvim_get_current_buf()
        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = buf })
      end, { desc = "Toggle Inlay Hints" })

      -- Enable built-in inlay hints ONCE per buffer when any LSP attaches
      local ih_group = vim.api.nvim_create_augroup("LspInlayHintsOnce", {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = ih_group,
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client or not client.server_capabilities.inlayHintProvider then return end
          local bufnr = args.buf
          if vim.b[bufnr].inlay_hints_set then return end
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          vim.b[bufnr].inlay_hints_set = true
        end,
      })

      -- If you have lsp-inlayhints.nvim installed somewhere, disable it
      pcall(function() require("lsp-inlayhints").setup({ enabled_at_startup = false }) end)

      -- rust-tools sets up rust_analyzer; we WON'T call lspconfig.rust_analyzer separately
      rt.setup({
        tools = {
          -- Let Neovim render hints; don't auto-draw via rust-tools
          inlay_hints = { auto = false },
        },
        server = {
          on_attach = on_attach,
          settings = {
            ["rust-analyzer"] = {
              inlayHints = {
                typeHints = true,
                parameterHints = true,
                chainingHints = true,
              },
              cargo = { allFeatures = true },
              checkOnSave = { command = "clippy" },
            },
          },
        },
      })
    end,
  },

  -- LSP configs for everything else
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Same on_attach used above to keep behavior consistent
      local on_attach = function(_, bufnr)
        vim.keymap.set("n", "K",  vim.lsp.buf.hover,        { buffer = bufnr })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration,  { buffer = bufnr })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition,   { buffer = bufnr })
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = bufnr })
        vim.keymap.set("n", "jk", vim.lsp.buf.format,       { buffer = bufnr })
      end

      -- Apply on_attach to all servers by default
      lspconfig.util.default_config = vim.tbl_extend(
        "force",
        lspconfig.util.default_config,
        { on_attach = on_attach }
      )


      -- Servers (do NOT set up rust_analyzer here; rust-tools does it)
      lspconfig.lua_ls.setup({})
      lspconfig.pyright.setup({})
      lspconfig.sqls.setup({})
      lspconfig.cssls.setup({})
      lspconfig.prismals.setup({})
      lspconfig.ts_ls.setup({})
      lspconfig.tailwindcss.setup({})
      lspconfig.html.setup({})
      lspconfig.clangd.setup({})
    end,
  },
}
