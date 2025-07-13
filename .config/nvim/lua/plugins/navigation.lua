return {
    -- Navigation
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            -- You dont need to set any of these options. These are the default ones. Only
            -- the loading is important
            local ts = require('telescope')
            ts.setup {
                defaults = {
                    -- Default configuration for telescope goes here:
                    -- config_key = value,
                    mappings = {
                        i = {
                            -- map actions.which_key to <C-h> (default: <C-/>)
                            -- actions.which_key shows the mappings for your picker,
                            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                            ["<C-h>"] = "which_key"
                        }
                    }
                },
                pickers = {
                    -- Default configuration for builtin pickers goes here:
                    -- picker_name = {
                    --   picker_config_key = value,
                    --   ...
                    -- }
                    -- Now the picker_config_key will be applied every time you call this
                    -- builtin picker
                },
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                }
            }

            -- To get fzf loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            ts.load_extension('fzf')

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>tf', builtin.find_files, {})
            vim.keymap.set('n', '<leader>tg', builtin.git_files, {})
            vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>th', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>ts', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") });
            end)
        end
    },
    {
        'stevearc/oil.nvim', -- File manager (netrw replacement)
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    },
    {
        'ggandor/leap.nvim', -- Jump wherever
        init = function()
            local leap = require('leap')
            leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
            leap.set_default_mappings()
        end
    }
}
