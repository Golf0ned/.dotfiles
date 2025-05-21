-- autocommand to map ctrl+\ + <key> to ctrl+k + <key> + * to insert greek
vim.api.nvim_create_autocmd("FileType", {
    pattern = "racket",
    callback = function()
        -- local make_greek = function(key)
        --     vim.keymap.set("i", "<C-\\>" .. key, ("<C-k>" .. key .. "*"), { buffer = true })
        -- end

        vim.keymap.set("i", "<C-\\>", "λ", { buffer = true })
    end
})

return { "benknoble/vim-racket" }
