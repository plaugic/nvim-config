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
        "rcarriga/nvim-notify",
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
        {
            "folke/which-key.nvim", opts = {}
        },
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
        -- { 
        --     -- Rating 3/10
        --     "mcchrish/zenbones.nvim",
        --     priority = 1000,
        --     -- Specify the dependency on lush.nvim
        --     dependencies = {
        --         "rktjmp/lush.nvim"
        --     },
        --     -- Configuration block (if needed)
        --     config = function()
        --         -- Here you can add any Lua code needed to configure zenbones.nvim
        --         -- For example, if you need to set a global variable for compatibility:
        --         vim.g.zenbones_compat = 1  -- Uncomment this line if you're using Vim or don't want to install lush.nvim
        --         vim.cmd("colorscheme zenbones")
        --     end
        -- },
        -- { 
        --     -- Rating 5/10
        --     "catppuccin/nvim",
        --     priority = 1000,
        --     config = function()
        --         vim.cmd.colorscheme "catppuccin"
        --     end
        -- },
        -- { 
        --     -- Rating 5/10
        --     "lmburns/kimbox",
        --     priority = 1000,
        --     config = function()
        --         vim.cmd.colorscheme "kimbox"
        --     end
        -- },
        -- { 
        --     -- Rating 6/10
        --     "sainnhe/everforest",
        --     priority = 1000,
        --     config = function()
        --         vim.g.everforest_background = 'hard'
        --         vim.cmd.colorscheme "everforest"
        --     end
        -- },
        -- { 
        --     -- Rating 6/10
        --     "shaunsingh/moonlight.nvim",
        --     config = function()
        --         vim.cmd("colorscheme moonlight")
        --     end
        -- },
        -- { 
        --     -- Rating 6/10
        --     "cpea2506/one_monokai.nvim",
        --     priority = 1000,
        --     config = function()
        --         vim.cmd.colorscheme "one_monokai"
        --     end
        -- },
        -- {
        --     -- Rating 7/10
        --     "morhetz/gruvbox",
        --     priority = 1000,
        --     config = function()
        --         vim.cmd.colorscheme "gruvbox"
        --     end
        -- },
        -- { 
        --     -- Rating 7/10
        --     "navarasu/onedark.nvim",
        --     priority = 1000,
        --     config = function()
        --         vim.cmd.colorscheme "onedark"
        --     end
        -- },
        -- { 
        --     -- Rating 7/10
        --     "sainnhe/gruvbox-material",
        --     priority = 1000,
        --     config = function()
        --         -- Check if termguicolors is supported and enable it
        --         if vim.fn.has('termguicolors') == 1 then
        --             vim.o.termguicolors = true
        --         end 
        --         -- Set the background to light or dark
        --         -- vim.o.background = 'light'  -- or 'dark' 
        --         -- Set gruvbox-material specific configurations
        --         vim.g.gruvbox_material_background = 'hard'
        --         vim.g.gruvbox_material_better_performance = 1
        --         -- Apply the colorscheme
        --         vim.cmd("colorscheme gruvbox-material")
        --         -- Configure lightline (if you're using it)
        --         -- Uncomment the following line if you use lightline and want to set its colorscheme
        --         -- vim.g.lightline = { colorscheme = 'gruvbox_material' }
        --     end
        -- },
        -- { 
        --     -- Rating 7/10
        --     "nxvu699134/vn-night.nvim",
        --     priority = 1000,
        --     config = function()
        --         vim.cmd.colorscheme "vn-night"
        --     end
        -- },
        -- {
        --     -- Rating 7.5/10
        --     "savq/melange-nvim",
        --     priority = 1000,
        --     config = function()
        --         vim.cmd.colorscheme "melange"
        --     end
        -- },
        -- { 
        --     -- Rating 8/10
        --     "tiagovla/tokyodark.nvim",
        --     priority = 1000,
        --     config = function()
        --         vim.cmd.colorscheme "tokyodark"
        --     end
        -- },
        -- { 
        --     -- Rating 9/10
        --     "bluz71/vim-moonfly-colors",
        --     priority = 1000,
        --     config = function()
        --         vim.cmd.colorscheme "moonfly"
        --     end
        -- },
        -- { 
        --     -- Rating 9/10
        --     "ray-x/aurora",
        --     priority = 1000,
        --     config = function()
        --         vim.cmd.colorscheme "aurora"
        --     end
        -- },
        --   
        --   
        --   
        -- PREFER THIS FONT FOR LIGHT MODE
        {
            -- Rating 9/10
            "olimorris/onedarkpro.nvim",
            priority = 1000,
            config = function()
                require("onedarkpro").setup({
                    options = {
                        transparency = true -- this will enable transparency
                    }
                })
                vim.cmd.colorscheme "onedark_dark"
            end
        },
        --   
        --   
        -- PREFER THIS FONT FOR DARK MODE
        -- { 
        --     -- Rating 9.5/10
        --     "nyoom-engineering/oxocarbon.nvim",
        --     priority = 1000,
        -- },
        --
        --
        -- { 
        --     -- Rating 9/10 [military/camo vibes with this one]
        --     "xero/miasma.nvim",
        --     priority = 1000,
        -- },
        --
        --
        {
            -- Set lualine as statusline
            "nvim-lualine/lualine.nvim",
            -- See `:help lualine.txt`
            opts = {
                options = {
                    icons_enabled = true,
                    theme = "onedark",
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
                vim.keymap.set("n", "tt", ":NvimTreeToggle<CR>", {})
                vim.keymap.set("n", "tc", ":NvimTreeClose<CR>", {})
                vim.keymap.set("n", "to", ":NvimTreeOpen<CR>", {})
            end
        },
        -- "gc" to comment visual regions/lines
        {
            "numToStr/Comment.nvim", opts = {}
        },
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
                    "<leader>t]",
                    function()
                        require("todo-comments").jump_next()
                    end,
                    {desc = "Next [T]o-Do -> ]"}
                ),
                vim.keymap.set(
                    "n",
                    "<leader>t[",
                    function()
                        require("todo-comments").jump_prev()
                    end,
                    {desc = "Previous [T]o-Do -> ["}
                ),
                vim.keymap.set("n", "<leader>ts", ":TodoTelescope<CR>", {desc = "[T]o-Do [S]earch"})
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
        },
        {
            "dreamsofcode-io/ChatGPT.nvim",
            event = "VeryLazy",
            dependencies = {
                "MunifTanjim/nui.nvim",
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope.nvim",
            },
            config = function()
                require("chatgpt").setup({
                    api_key_cmd = "pass show api/tokens/openai",
                    openai_params = {
                      model = "gpt-4-1106-preview",
                    },
                    openai_edit_params = {
                      model = "gpt-4-1106-preview",
                    }
                })
            end,
        }
        -- Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
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
