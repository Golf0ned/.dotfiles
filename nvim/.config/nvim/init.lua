--
-- Settings
--

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Line
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.wrap = false

-- Indent
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- Undo
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

-- Colors
vim.o.termguicolors = true
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

--
-- Keymaps
--

-- Clear search highlight
vim.keymap.set("n", "<esc>", "<cmd>noh<cr>")

-- Centering
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- LSP
vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end)
vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end)

-- Move lines in visual
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]])

-- Retain buffer on paste
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Delete to void
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Join keeps line
vim.keymap.set("n", "J", "mzJ`z")

-- Presenter mode (i have used this once!)
vim.keymap.set("n", "<leader>;;", "<cmd>set background=light<cr><cmd>colorscheme retrobox<cr>")

-- Open config
vim.keymap.set("n", "<leader>nn", function()
    vim.cmd("edit " .. vim.fn.stdpath("config") .. "/init.lua")
end)

--
-- Plugins
-- (switching to vim.pack eventually)
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        --
        -- 0. Collections
        --
        {
            "nvim-mini/mini.nvim",
            config = function()
                require("mini.ai").setup()
                require("mini.diff").setup()
                require("mini.git").setup()
                require("mini.icons").setup()
                require("mini.statusline").setup()
                require("mini.surround").setup()
            end,
        },

        --
        -- 1. Editor
        --
        {
            "HiPhish/rainbow-delimiters.nvim",
            config = function()
                require("rainbow-delimiters.setup").setup({
                    highlight = {
                        "RainbowDelimiterYellow",
                        "RainbowDelimiterViolet",
                        "RainbowDelimiterBlue",
                    },
                })
            end,
        },
        {
            "saghen/blink.indent",
            opts = {
                scope = {
                    highlights = { "BlinkIndentScope" },
                },
            },
        },

        --
        -- 2. Navigation
        --
        {
            "dmtrKovalenko/fff.nvim",
            build = function()
                require("fff.download").download_or_build_binary()
            end,
            opts = {},
            config = function()
                local fff = require("fff")
                vim.keymap.set("n", "<leader>sf", fff.find_files)
                vim.keymap.set("n", "<leader>sg", fff.live_grep)
            end,
        },
        {
            "stevearc/oil.nvim",
            dependencies = { "nvim-mini/mini.nvim" },
            config = function()
                require("oil").setup({
                    watch_for_changes = true,
                    keymaps = {
                        ["-"] = { "actions.parent", mode = "n" },
                        ["_"] = { "actions.open_cwd", mode = "n" },
                        ["<C-h>"] = false,
                        ["<C-l>"] = false,
                    },
                    view_options = {
                        show_hidden = true,
                    },
                    win_options = {
                        signcolumn = "yes",
                        winbar = "%{v:lua.require('oil').get_current_dir()}",
                    },
                })
                vim.keymap.set("n", "-", "<CMD>Oil<CR>")
            end,
        },
        {
            "ThePrimeagen/harpoon",
            branch = "harpoon2",
            dependencies = { "nvim-lua/plenary.nvim" },
            config = function()
                local harpoon = require("harpoon")
                harpoon:setup()

                vim.keymap.set("n", "<leader>hh", function()
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end)
                vim.keymap.set("n", "<leader>ha", function()
                    harpoon:list():add()
                end)
                for i = 1, 5 do
                    vim.keymap.set("n", "<leader>h" .. i, function()
                        harpoon:list():select(i)
                    end)
                end
            end,
        },
        {
            "christoomey/vim-tmux-navigator",
            keys = {
                { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
                { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
                { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
                { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
                { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
            },
        },

        --
        -- 3. Treesitter
        --
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                local function treesitter_try_attach(buf, language)
                    if not vim.treesitter.language.add(language) then
                        return
                    end
                    vim.treesitter.start(buf, language)
                end

                local available_parsers = require("nvim-treesitter").get_available()
                vim.api.nvim_create_autocmd("FileType", {
                    callback = function(args)
                        local buf, filetype = args.buf, args.match

                        local language = vim.treesitter.language.get_lang(filetype)
                        if not language then
                            return
                        end

                        local installed_parsers = require("nvim-treesitter").get_installed("parsers")

                        if vim.tbl_contains(installed_parsers, language) then
                            treesitter_try_attach(buf, language)
                        elseif vim.tbl_contains(available_parsers, language) then
                            require("nvim-treesitter").install(language):await(function()
                                treesitter_try_attach(buf, language)
                            end)
                        else
                            treesitter_try_attach(buf, language)
                        end
                    end,
                })
            end,
        },

        --
        -- 4. LSP
        --
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                { "saghen/blink.cmp" },
                { "williamboman/mason.nvim", opts = {} },
                { "williamboman/mason-lspconfig.nvim" },
            },
            config = function()
                local servers = {
                    basedpyright = {
                        settings = {
                            basedpyright = {
                                typeCheckingMode = "off",
                            },
                        },
                    },
                    clangd = {
                        init_options = {
                            fallbackFlags = {
                                "-std=c++23",
                            },
                        },
                    },
                    lua_ls = {},
                    rust_analyzer = {},
                }

                local ensure_installed = vim.tbl_keys(servers or {})

                require("mason-lspconfig").setup({
                    ensure_installed = ensure_installed,
                    automatic_installation = false,
                    handlers = {
                        function(server_name)
                            local server = servers[server_name] or {}
                            server.capabilities = require("blink.cmp").get_lsp_capabilities()
                            require("lspconfig")[server_name].setup(server)
                        end,
                    },
                })
            end,
        },
        {
            "saghen/blink.cmp",
            version = "1.*",
            opts = {},
        },
        {
            "stevearc/conform.nvim",
            keys = {
                {
                    "<leader>f",
                    function()
                        require("conform").format({ async = true, lsp_format = "fallback" })
                    end,
                },
            },
        },
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {},
        },

        --
        -- 5. Themes
        --
        {
            "folke/tokyonight.nvim",
            priority = 1000,
            config = function()
                require("tokyonight").setup({
                    style = "night",
                    styles = {
                        keywords = { italic = false },
                    },
                    on_colors = function(colors)
                        colors.git = {
                            add = colors.green,
                            change = colors.yellow,
                            delete = colors.red,
                        }
                    end,
                    on_highlights = function(highlights, colors)
                        highlights.MatchParen = {
                            bg = colors.blue0,
                        }
                    end,
                })
                vim.cmd.colorscheme("tokyonight")
            end,
        },
        { "EdenEast/nightfox.nvim" },
        { "Mofiqul/vscode.nvim" },
        { "vague2k/vague.nvim" },
    },
})
