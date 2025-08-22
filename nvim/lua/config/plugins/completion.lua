-- return {
--   {
--     'saghen/blink.cmp',
--     enabled = false,
--   },
--
--   {
--     'hrsh7th/cmp-nvim-lsp',
--   },
--
--   {
--     'L3MON4D3/LuaSnip',
--     dependencies = {
--       'rafamadriz/friendly-snippets',
--     },
--     config = function()
--       require('luasnip.loaders.from_vscode').lazy_load()
--       require('luasnip.loaders.from_lua').load { paths = '~/.config/nvim/lua/snippets' }
--     end,
--   },
--
--   {
--     'hrsh7th/nvim-cmp',
--     event = 'InsertEnter',
--     dependencies = {
--       'saadparwaiz1/cmp_luasnip',
--       'hrsh7th/cmp-buffer',
--       'hrsh7th/cmp-path',
--       'hrsh7th/cmp-cmdline',
--     },
--     config = function()
--       local cmp = require 'cmp'
--       local luasnip = require 'luasnip'
--
--       cmp.setup {
--         snippet = {
--           expand = function(args)
--             luasnip.lsp_expand(args.body)
--           end,
--         },
--         window = {
--           completion = cmp.config.window.bordered(),
--           documentation = cmp.config.window.bordered(),
--         },
--         mapping = cmp.mapping.preset.insert {
--           ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--           ['<C-f>'] = cmp.mapping.scroll_docs(4),
--           ['<C-Space>'] = cmp.mapping.complete(),
--           ['<C-e>'] = cmp.mapping.abort(),
--           ['<CR>'] = cmp.mapping.confirm { select = true },
--
--           ['<Tab>'] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--               cmp.select_next_item()
--             elseif luasnip.expand_or_jumpable() then
--               luasnip.expand_or_jump()
--             else
--               fallback()
--             end
--           end, { 'i', 's' }),
--
--           ['<S-Tab>'] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--               cmp.select_prev_item()
--             elseif luasnip.jumpable(-1) then
--               luasnip.jump(-1)
--             else
--               fallback()
--             end
--           end, { 'i', 's' }),
--         },
--         sources = cmp.config.sources({
--           { name = 'nvim_lsp' },
--           { name = 'luasnip' },
--         }, {
--           { name = 'buffer' },
--           { name = 'path' },
--         }),
--         formatting = {
--           format = function(entry, vim_item)
--             vim_item.menu = ({
--               nvim_lsp = '[LSP]',
--               luasnip = '[Snippet]',
--               buffer = '[Buffer]',
--               path = '[Path]',
--             })[entry.source.name]
--             return vim_item
--           end,
--         },
--       }
--
--       -- Optional: cmdline completion for `:` and `/`
--       cmp.setup.cmdline(':', {
--         mapping = cmp.mapping.preset.cmdline(),
--         sources = cmp.config.sources({
--           { name = 'path' },
--         }, {
--           { name = 'cmdline' },
--         }),
--       })
--
--       cmp.setup.cmdline({ '/', '?' }, {
--         mapping = cmp.mapping.preset.cmdline(),
--         sources = {
--           { name = 'buffer' },
--         },
--       })
--     end,
--   },
-- }
return {
  {
    "saghen/blink.cmp",
    enabled = false,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
