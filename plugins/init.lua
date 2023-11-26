-- plugins/init.lua
-- Entry point for plugin configurations

-- NOTE: Here is where you install your plugins.
-- You can configure plugins using the `config` key.
--
-- You can also configure plugins after the setup call,
-- as they will be available in your neovim runtime.
require("lazy").setup(
    {
        -- NOTE: First, some plugins that don't require any configuration

        -- Git related plugins
        "tpope/vim-fugitive",
        "tpope/vim-rhubarb",
        -- Detect tabstop and shiftwidth automatically
        "tpope/vim-sleuth",
        -- NOTE: This is where your plugins related to LSP can be installed.
        -- The configuration is done below. Search for lspconfig to find it below.
        {
            -- LSP Configuration & Plugins
            "neovim/nvim-lspconfig",
            dependencies = {
                -- Automatically install LSPs to stdpath for neovim
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",
                -- Useful status updates for LSP
                -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
                {"j-hui/fidget.nvim", tag = "legacy", opts = {}},
                -- Additional lua configuration, makes nvim stuff amazing!
                "folke/neodev.nvim"
            }
        },
        {
            "kevinhwang91/nvim-ufo",
            dependencies = {"kevinhwang91/promise-async"},
            config = function()
                vim.o.foldcolumn = "1"
                vim.o.foldlevel = 99
                vim.o.foldlevelstart = 99
                vim.o.foldenable = true
                vim.keymap.set("n", "zR", require("ufo").openAllFolds)
                vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

                require("ufo").setup(
                    {
                        open_fold_hl_timeout = 400, -- Time in millisecond between the range to be highlighted and to be cleared
                        provider_selector = function(bufnr, filetype, buftype)
                            return {"treesitter", "indent"} -- 'lsp' and 'treesitter' as main provider, 'indent' as fallback
                        end,
                        close_fold_kinds = {}, -- Standardized kinds are 'comment', 'imports' and 'region'
                        fold_virt_text_handler = nil, -- A function to customize fold virt text
                        enable_get_fold_virt_text = false, -- Enable a function to capture the virtual text for the folded lines
                        preview = {
                            win_config = {
                                border = "rounded", -- The border for preview window
                                winblend = 12, -- The winblend for preview window
                                winhighlight = "Normal:Normal", -- The winhighlight for preview window
                                maxheight = 20 -- The max height of preview window
                            },
                            mappings = {} -- The table for {function = key}
                        }
                    }
                )
            end
        },
        {
            -- Autocompletion
            "hrsh7th/nvim-cmp",
            dependencies = {
                -- Snippet Engine & its associated nvim-cmp source
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",
                -- Adds LSP completion capabilities
                "hrsh7th/cmp-nvim-lsp",
                -- Adds a number of user-friendly snippets
                "rafamadriz/friendly-snippets"
            }
        },
        {
            "goolord/alpha-nvim",
            dependencies = {"nvim-tree/nvim-web-devicons"},
            config = function()
                require "alpha".setup(require "alpha.themes.startify".config)
            end
        },
        -- Useful plugin to show you pending keybinds.
        {"folke/which-key.nvim", opts = {}},
        {
            -- Adds git related signs to the gutter, as well as utilities for managing changes
            "lewis6991/gitsigns.nvim",
            opts = {
                -- See `:help gitsigns.txt`
                signs = {
                    add = {text = "+"},
                    change = {text = "~"},
                    delete = {text = "_"},
                    topdelete = {text = "‾"},
                    changedelete = {text = "~"}
                },
                on_attach = function(bufnr)
                    vim.keymap.set(
                        "n",
                        "hp",
                        require("gitsigns").preview_hunk,
                        {buffer = bufnr, desc = "Preview git hunk"}
                    )

                    -- don't override the built-in and fugitive keymaps
                    local gs = package.loaded.gitsigns
                    vim.keymap.set(
                        {"n", "v"},
                        "]c",
                        function()
                            if vim.wo.diff then
                                return "]c"
                            end
                            vim.schedule(
                                function()
                                    gs.next_hunk()
                                end
                            )
                            return ""
                        end,
                        {expr = true, buffer = bufnr, desc = "Jump to next hunk"}
                    )
                    vim.keymap.set(
                        {"n", "v"},
                        "[c",
                        function()
                            if vim.wo.diff then
                                return "[c"
                            end
                            vim.schedule(
                                function()
                                    gs.prev_hunk()
                                end
                            )
                            return ""
                        end,
                        {expr = true, buffer = bufnr, desc = "Jump to previous hunk"}
                    )
                end
            }
        },
        {
            "morhetz/gruvbox",
            priority = 1000,
            config = function()
                vim.cmd.colorscheme "gruvbox"
            end
        },
        {
            -- Set lualine as statusline
            "nvim-lualine/lualine.nvim",
            -- See `:help lualine.txt`
            opts = {
                options = {
                    icons_enabled = true,
                    theme = "gruvbox",
                    component_separators = "::",
                    section_separators = ""
                }
            }
        },
        {
            -- Add indentation guides even on blank lines
            "lukas-reineke/indent-blankline.nvim",
            -- Enable `lukas-reineke/indent-blankline.nvim`
            -- See `:help ibl`
            main = "ibl",
            opts = {}
        },
        {
            "nvim-tree/nvim-tree.lua",
            version = "*",
            lazy = false,
            dependencies = {
                "nvim-tree/nvim-web-devicons"
            },
            config = function()
                require("nvim-tree").setup {}
                vim.keymap.set("n", "tt", "NvimTreeToggle", {})
                vim.keymap.set("n", "tc", "NvimTreeClose", {})
                vim.keymap.set("n", "to", "NvimTreeOpen", {})
            end
        },
        -- "gc" to comment visual regions/lines
        {"numToStr/Comment.nvim", opts = {}},
        -- Fuzzy Finder (files, lsp, etc)
        {
            "nvim-telescope/telescope.nvim",
            branch = "0.1.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
                -- Fuzzy Finder Algorithm which requires local dependencies to be built.
                -- Only load if `make` is available. Make sure you have the system
                -- requirements installed.
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    -- NOTE: If you are having trouble with this installation,
                    -- refer to the README for telescope-fzf-native for moons.
                    build = "make",
                    cond = function()
                        return vim.fn.executable "make" == 1
                    end
                }
            }
        },
        {
            "mg979/vim-visual-multi",
            config = function()
                -- Your configuration code for vim-visual-multi goes here, if any.
                -- Since vim-visual-multi is mostly configured via Vimscript,
                -- you might not need to put anything here.
            end
        },
        {
            -- Highlight, edit, and navigate code
            "nvim-treesitter/nvim-treesitter",
            dependencies = {
                "nvim-treesitter/nvim-treesitter-textobjects"
            },
            build = ":TSUpdate"
        },
        {
            "folke/trouble.nvim",
            dependencies = {"nvim-tree/nvim-web-devicons"},
            opts = {}
        },
        {
            "rmagatti/goto-preview",
            config = function()
                require("goto-preview").setup {}

                -- go-to preview mappings
                vim.keymap.set(
                    "n",
                    "gpd",
                    function()
                        require("goto-preview").goto_preview_definition()
                    end,
                    {desc = "[G]o To [P]review [D]efinition"}
                )
                vim.keymap.set(
                    "n",
                    "gpt",
                    function()
                        require("goto-preview").goto_preview_type_definition()
                    end,
                    {desc = "[G]o To [P]review [T]ype Definition"}
                )
                vim.keymap.set(
                    "n",
                    "gpi",
                    function()
                        require("goto-preview").goto_preview_implementation()
                    end,
                    {desc = "[G]o To [P]review [I]mplementation"}
                )
                vim.keymap.set(
                    "n",
                    "gpD",
                    function()
                        require("goto-preview").goto_preview_declaration()
                    end,
                    {desc = "[G]o To [P]review [D]eclaration"}
                )
                vim.keymap.set(
                    "n",
                    "gpc",
                    function()
                        require("goto-preview").close_all_win()
                    end,
                    {desc = "[G]o To [P]review [C]lose All"}
                )
                vim.keymap.set(
                    "n",
                    "gpr",
                    function()
                        require("goto-preview").goto_preview_references()
                    end,
                    {desc = "[G]o To [P]review [R]eferences"}
                )
            end
        },
        {
            "folke/todo-comments.nvim",
            dependencies = {"nvim-lua/plenary.nvim"},
            opts = {
                vim.keymap.set(
                    "n",
                    "t]",
                    function()
                        require("todo-comments").jump_next()
                    end,
                    {desc = "Next [T]o-Do -> ]"}
                ),
                vim.keymap.set(
                    "n",
                    "t[",
                    function()
                        require("todo-comments").jump_prev()
                    end,
                    {desc = "Previous [T]o-Do -> ["}
                ),
                vim.keymap.set("n", "ts", "TodoTelescope", {desc = "[T]o-Do [S]earch"})
            }
        },
        {
            "ray-x/go.nvim",
            dependencies = {
                -- optional packages
                "ray-x/guihua.lua",
                "neovim/nvim-lspconfig",
                "nvim-treesitter/nvim-treesitter"
            },
            config = function()
                require("go").setup()
            end,
            event = {"CmdlineEnter"},
            ft = {"go", "gomod"},
            build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
        }
        -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
        -- These are some example plugins that I've included in the kickstart repository.
        -- Uncomment any of the lines below to enable them.
        -- require 'kickstart.plugins.autoformat',
        -- require 'kickstart.plugins.debug',

        -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
        -- You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
        -- up-to-date with whatever is in the kickstart repo.
        -- Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
        --
        -- For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
        -- { import = 'custom.plugins' },
    }, {})

-- Note: Specific configurations for each plugin should be moved to their respective files.
-- For example, the configuration for 'nvim-cmp' should be in 'plugins/completion.lua'.

-- Load completion plugins configurations
-- require('plugins.completion')

-- Load Telescope configurations
require('plugins.telescope')

-- Load Treesitter configurations
require('plugins.treesitter')

-- Load LSP plugins configurations
require('plugins.lsp')

-- Load UI enhancement plugins configurations
require('plugins.ui-enhancements')

-- Load Which-Key configurations
require('plugins.which-key')

-- Load utility plugins configurations
-- require('plugins.utility-plugins')

-- Add more plugin configuration files as needed
