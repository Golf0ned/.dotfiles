return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", opts = {} },
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            -- TODO: add LSP keymaps

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
                            "-std=c++17",
                        },
                    }
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
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                }
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "L3MON4D3/LuaSnip" },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                sources = {
                    {name = "nvim_lsp"},
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({select = false}),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
            })
        end,
    },
}
