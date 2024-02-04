return {
    {
        -- Pair quotes/brackets
        "windwp/nvim-autopairs",
        lazy = false,
        config = function()

        end
    },
    {
        "windwp/nvim-ts-autotag", 
        lazy = false,
        dependencies = {
            "hrsh7th/nvim-cmp",
        },

        config = function()

            local autopairs = require("nvim-autopairs")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")

            autopairs.setup({
                disable_filetype = { "TelescopePrompt", "vim" },
            })

            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

            require("nvim-treesitter.configs").setup({
                autotag = {
                    enable = true,
                },
            })
        end

    },
}
