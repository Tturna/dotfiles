return {
    -- Completion
    {
        -- completion engine
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                sources = cmp.config.sources({
                    { name = 'nvim_lua' },
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
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
                    documentation = cmp.config.window.bordered(),
                    completion = cmp.config.window.bordered()
                },
                view = {
                    entries = { name = 'custom', selection_order = 'near_cursor' }
                },
            })

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })
        end
    },
    { 'hrsh7th/cmp-buffer' }, -- complete items from your buffer
    { 'hrsh7th/cmp-path' }, -- complete paths (like files)
    { 'hrsh7th/cmp-nvim-lua' }, -- complete vim stuff like vim.api items
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'saadparwaiz1/cmp_luasnip' },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        dependencies = { "rafamadriz/friendly-snippets" },
        build = "make install_jsregexp",
        config = function()
            local ls = require("luasnip")
            local rep = require("luasnip.extras").rep
            local fmta = require("luasnip.extras.fmt").fmta
            local txt = ls.text_node
            local ins = ls.insert_node

            ls.config.set_config {
                enable_autosnippets = true
            }

            vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-H>", function() ls.jump(-1) end, {silent = true})

            vim.keymap.set({"i", "s"}, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, {silent = true})

            ls.add_snippets("javascript", {
                ls.snippet("hello", {
                    txt("world")
                })
            })

            ls.add_snippets("cs", {
                ls.snippet("gc", fmta(
                    [[
                    using Microsoft.Xna.Framework;

                    namespace <namespace>;

                    public class <class> : GameComponent
                    {
                        public <constructor>(Game game) : base(game)
                        {
                            <cursor>
                        }

                        public override void Initialize()
                        {
                            base.Initialize();
                        }

                        public override void Update(GameTime gameTime)
                        {
                            base.Update(gameTime);
                        }
                    }
                    ]],
                    { namespace = ins(1, "namespace"), class = ins(2, "class"), constructor = rep(2), cursor = ins(3)}
                )),
                ls.snippet("dgc", fmta(
                    [[
                    using Microsoft.Xna.Framework;
                    using Microsoft.Xna.Framework.Graphics;

                    namespace <namespace>;

                    public class <class> : DrawableGameComponent
                    {
                        public <constructor>(Game game) : base(game)
                        {
                            <cursor>
                        }

                        public override void Initialize()
                        {
                            base.Initialize();
                        }

                        protected override void LoadContent()
                        {
                        }

                        public override void Update(GameTime gameTime)
                        {
                            base.Update(gameTime);
                        }

                        public override void Draw(GameTime gameTime)
                        {
                            base.Draw(gameTime);
                        }
                    }
                    ]],
                    { namespace = ins(1, "namespace"), class = ins(2, "class"), constructor = rep(2), cursor = ins(3)}
                ))
            })

            -- Load snippets from rafamadriz/friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    },
}
