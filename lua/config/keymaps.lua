vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Project Viewer" }) -- Project Viewer

vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files() end, { desc = "Find Files" })
vim.keymap.set('n', '<leader>fg', function() require('telescope.builtin').live_grep() end, { desc = "Live Grep" })
vim.keymap.set('n', '<leader>fb', function() require('telescope.builtin').buffers() end, { desc = "Buffers" })

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })

--save file
vim.keymap.set("n", "<leader>zz", vim.cmd.w, { silent = true })

vim.keymap.set('n', '<C-d>', '<C-d>zz0')
vim.keymap.set('n', '<C-u>', '<C-u>zz0')

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('i', 'jj', "<Esc>", { noremap = true})

vim.keymap.set("n", "*", "*zz", { noremap = true, silent = true })
vim.keymap.set("n", "#", "#zz", { noremap = true, silent = true })


-- LSP --
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show error under cursor" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Show all errors" })

vim.keymap.set("n", "zz", function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    -- Format if LSP is available
    if #clients > 0 then
        vim.lsp.buf.format({ timeout_ms = 1000 })
    end


    -- Center cursor (original zz behavior)
    vim.cmd("normal! zz")
end, { noremap = true, silent = true })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })

