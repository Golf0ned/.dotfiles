return {
    {
        "nvim-mini/mini.ai",
        version = false,
        opts = {},
    },
    {
        "nvim-mini/mini.surround",
        version = false,
        opts = {
            -- mappings = {
            --     add = "ys",
            --     delete = "ds",
            --     find = "gs",
            --     find_left = "gS",
            --     highlight = "gsh",
            --     replace = "cs",
            --     update_n_lines = "",
            -- },
        },
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {}
    },
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
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local parsers = { "bash", "c", "cpp", "diff", "html", "lua", "luadoc", "markdown", "markdown_inline",
                "python", "query", "rust", "vim", "vimdoc" }
            require("nvim-treesitter").install(parsers)

            local function treesitter_try_attach(buf, language)
                if not vim.treesitter.language.add(language) then return end
                vim.treesitter.start(buf, language)
            end

            local available_parsers = require("nvim-treesitter").get_available()
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local buf, filetype = args.buf, args.match

                    local language = vim.treesitter.language.get_lang(filetype)
                    if not language then return end

                    local installed_parsers = require("nvim-treesitter").get_installed "parsers"

                    if vim.tbl_contains(installed_parsers, language) then
                        treesitter_try_attach(buf, language)
                    elseif vim.tbl_contains(available_parsers, language) then
                        require("nvim-treesitter").install(language):await(function() treesitter_try_attach(buf, language) end)
                    else
                        treesitter_try_attach(buf, language)
                    end
                end,
            })
        end
    },
}
