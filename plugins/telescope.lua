-- plugins/telescope.lua
-- Configuration for Telescope plugin

require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false
            }
        }
    },
    pickers = {
        -- Specific configurations for different pickers provided by Telescope
        find_files = {
            -- Example configuration
            -- hidden = true
        },
    },
    extensions = {
        -- Extensions configuration
        fzf = {
            -- Specific config for the fzf extension, if you use it
        },
    },
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- Load Telescope extensions
-- telescope.load_extension('fzf')

-- Add more specific configurations or custom pickers if needed

