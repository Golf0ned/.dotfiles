return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {},
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            vim.g.rainbow_delimiters = {
                highlight = {
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterBlue",
                },
            }
        end
    },
}
