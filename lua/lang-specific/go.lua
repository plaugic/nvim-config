-- Create an augroup named 'Go'
local go_group = vim.api.nvim_create_augroup("Go", {clear = true})

-- Add an autocmd to the 'Go' group
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        group = go_group,
        pattern = "*.go",
        callback = function()
            -- Run goimports on the saved file
            vim.cmd("silent! !goimports -w " .. vim.fn.expand("%"))

            -- Reload the file in the buffer
            vim.cmd("edit")
        end
    }
)
