vim.cmd [[set completeopt=menu,menuone,noselect]]

-- Setup nvim-cmp.
local status_ok, cmp = pcall(require, 'cmp')

if not status_ok then
    vim.notify("nvim-cmp is not exists", "warn")
    return
end

local status_ok, luasnip = pcall(require, "luasnip")

if not status_ok then
    vim.notify("LuaSnip is not exists", "warn")
    return
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local kind_icons = {
  Text = "󰦨",           -- nf-md-text
  Method = "",         -- nf-cod-symbol_method
  Function = "",       -- nf-cod-symbol_method
  Constructor = "",    -- nf-cod-symbol_method
  Field = "",          -- nf-cod-symbol_field
  Variable = "",       -- nf-cod-symbol_variable
  Class = "",          -- nf-cod-symbol_class
  Interface = "",      -- nf-cod-symbol_interface
  Module = "",         -- nf-cod-symbol_module
  Property = "",       -- nf-cod-symbol_property
  Unit = "",           -- nf-cod-symbol_unit
  Value = "",          -- nf-cod-symbol_value
  Enum = "",           -- nf-cod-symbol_enum
  Keyword = "",        -- nf-cod-symbol_keyword
  Snippet = "",        -- nf-cod-symbol_snippet
  Color = "",          -- nf-cod-symbol_color
  File = "",           -- nf-cod-symbol_file
  Reference = "",      -- nf-cod-symbol_reference
  Folder = "",         -- nf-cod-symbol_folder
  EnumMember = "",     -- nf-cod-symbol_enum_member
  Constant = "",       -- nf-cod-symbol_constant
  Struct = "",         -- nf-cod-symbol_struct
  Event = "",          -- nf-cod-symbol_event
  Operator = "",       -- nf-cod-symbol_operator
  TypeParameter = ""   -- nf-cod-symbol_type_parameter
}



cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp_document_symbol' },
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'path'},
    }),
    formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[LaTeX]",
      })[entry.source.name]
      return vim_item
    end
  },
  sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
