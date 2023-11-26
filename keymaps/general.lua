-- keymaps/general.lua
-- General key mappings

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Example of a general mapping (replace with actual mappings from your configuration)
-- map('n', '<some_key>', '<some_action>', opts)

vim.keymap.set({"n", "v"}, "<Space>", "<Nop>", {silent = true})
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true})
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true})

-- Normal mode mappings
vim.keymap.set("n", "<leader>mm", "<Plug>(VM-Enter)", {})
vim.keymap.set("n", "<leader>mn", "<Plug>(VM-Add-Cursor-Down)", {})
vim.keymap.set("n", "<leader>mp", "<Plug>(VM-Add-Cursor-Up)", {})
vim.keymap.set("n", "<leader>ma", "<Plug>(VM-Select-All)", {})

-- Visual mode mappings
vim.keymap.set("x", "<leader>mm", "<Plug>(VM-Enter)", {})
vim.keymap.set("x", "<leader>ma", "<Plug>(VM-Select-All)", {})
