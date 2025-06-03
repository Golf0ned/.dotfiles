return {
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = "auto",
            }
        }
    },
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup ({
                style = "night",
                styles = {
                    keywords = {italic = false },
                },
                on_colors = function(colors)
                    colors.git = {
                        -- add = "#82c13e",
                        -- change = "#d4902b",
                        -- delete = "#f10e38",
                        add = colors.green,
                        change = colors.yellow,
                        delete = colors.red,
                    }
                end,
                on_highlights = function(highlights, colors)
                    highlights.MatchParen = {
                        bg = colors.blue0,
                        bold = true,
                    }
                end,
            })
            vim.cmd.colorscheme "tokyonight"
        end
    },
    "EdenEast/nightfox.nvim",
    "rebelot/kanagawa.nvim",
}
