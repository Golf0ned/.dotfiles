return {
    "tpope/vim-surround",
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {}
    },
    {
        "echasnovski/mini.ai",
        version = false,
        config = function()
            local spec_treesitter = require("mini.ai").gen_spec.treesitter
            require("mini.ai").setup({
                custom_textobjects = {
                    f = spec_treesitter({
                        a = "@function.outer",
                        i = "@function.inner",
                    }),
                    c = spec_treesitter({
                        a = "@class.outer",
                        i = "@class.inner",
                    }),
                },
            })
        end,
    },
}
