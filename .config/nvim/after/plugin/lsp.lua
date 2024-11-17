vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
    callback = function(event)
        local opts = {buffer = event.buf}

        --[[
        -- See this link for configuration info. Note that it's the lsp-zero site but this setup doesn't use lsp-zero.
        -- https://lsp-zero.netlify.app/docs/language-server-configuration.html
        --]]
        vim.keymap.set('n', '<M-d>', function() vim.lsp.buf.hover() end, opts) -- Alt+d. Default 'K'
        vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts) -- Default 'gd'
        vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts) -- Default 'gr'
        vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts) -- Default 'gi'
        vim.keymap.set('n', '<F2>', function() vim.lsp.buf.rename() end, opts) -- Default <F2>
        vim.keymap.set('n', '<M-r>', function() vim.diagnostic.goto_next() end, opts) -- Default '[d'.
        vim.keymap.set('n', '<M-e>', function() vim.diagnostic.goto_prev() end, opts) -- Default ']d'.
        vim.keymap.set('n', '<leader>.', function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set('n', '<C-e>', function() vim.diagnostic.open_float() end, opts)
        --vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
        --vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
        --
    end,
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { },
    automatic_installation = true,
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({
                capabilities = lsp_capabilities,
            })
        end,
        lua_ls = function()
            require("lspconfig").lua_ls.setup({
                capabilities = lsp_capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT'
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                            }
                        }
                    }
                }
            })
        end,
    }
})

--[[
local configs = require 'lspconfig.configs'
configs.ast_grep = {
    default_config = {
        cmd = {'ast-grep', 'lsp'};
        single_file_support = false;
        root_dir = require("lspconfig").util.root_pattern('sgconfig.yml');
    };
}
--]]

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
    sources = cmp.config.sources({
        {name = 'nvim_lua'},
        {name = 'nvim_lsp'},
        {name = 'path'},
        {name = 'luasnip'},
    }, {
        {name = 'buffer'},
    }),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<CR>'] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
        ['<C-Space>'] = cmp.mapping.open_docs(),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        documentation = cmp.config.window.bordered()
    },
    view = {
      entries = { name = 'custom', selection_order = 'near_cursor' }
    },
})
