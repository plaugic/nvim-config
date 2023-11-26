-- keymaps/telescope.lua
-- Key mappings for Telescope plugin
vim.keymap.set('n', '<leader>sw', "<cmd>lua require('telescope.builtin').grep_string()<CR>", {desc = '[S]earch Current [W]ord'})
vim.keymap.set('n', '<leader>sg', "<cmd>lua require('telescope.builtin').live_grep()<CR>", {desc = '[S]earch By [G]rep'})
vim.keymap.set('n', '<leader>sd', "<cmd>lua require('telescope.builtin').diagnostics()<CR>", {desc = '[S]earch [D]iagnostics'})
vim.keymap.set('n', '<leader>sr', "<cmd>lua require('telescope.builtin').resume()<CR>", {desc = '[S]earch [R]esume'})
vim.keymap.set('n', '<leader><space>', "<cmd>lua require('telescope.builtin').buffers()<CR>", {desc = '[] Find Existing Buffers'})
vim.keymap.set('n', '<leader>gf', "<cmd>lua require('telescope.builtin').git_files()<CR>", {desc = '[G]it [F]iles'})
vim.keymap.set('n', '<leader>sf', "<cmd>lua require('telescope.builtin').find_files()<CR>", {desc = '[S]earch [F]iles'})
vim.keymap.set('n', '<leader>sh', "<cmd>lua require('telescope.builtin').help_tags()<CR>", {desc = '[S]earch [H]elp'})
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10, previewer = false,
  })
end, { desc = '[/] Fuzzy search in current buffer' })
