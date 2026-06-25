--
-- Bootstrap lazy.nvim
-- Still using for now until pack gets more fleshed out
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)


--
-- Settings
--

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Column
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

-- Line
vim.opt.cursorline = true
vim.opt.wrap = false

-- Indent
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Colors
vim.opt.termguicolors = true
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])


--
-- Bindings
--

-- Clear search highlight
vim.keymap.set("n", "<esc>", "<cmd>noh<cr>")

-- Diagnostic helpers
vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end)
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end)

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

-- Sanity centering
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Presenter mode
vim.keymap.set("n", "<leader>;;", "<cmd>set background=light<cr><cmd>colorscheme retrobox<cr>")

--
-- Plugins
--
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- automatically check for plugin updates
    checker = { enabled = false },
})
