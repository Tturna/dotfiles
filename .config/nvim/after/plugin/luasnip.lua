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
    ls.text_node("world")
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
