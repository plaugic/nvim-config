-- Treesitter configuration for enhanced syntax highlighting and more
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      "c", "cpp", "go", "lua", "python", "rust", "tsx",
      "javascript", "typescript", "vimdoc", "vim", "bash"
    },
    auto_install = false,
    highlight = {
      enable = true,              -- Enable Treesitter-based syntax highlighting
    },
    indent = {
      enable = true,              -- Enable Treesitter-based indentation
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-space>",          -- Begin a selection
        node_incremental = "<c-space>",        -- Increment to the upper named parent
        scope_incremental = "<c-s>",           -- Increment to the upper scope (function, class, etc.)
        node_decremental = "<M-space>",        -- Decrement to the previous node
      },
    },
    textobjects = {
      -- Define keymaps using the provided queries in textobjects.scm
      select = {
        enable = true,
        lookahead = true,                       -- Automatically jump forward to textobj
        keymaps = {
          ["aa"] = "@parameter.outer",          -- Select around a parameter
          ["ia"] = "@parameter.inner",          -- Select inside a parameter
          ["af"] = "@function.outer",           -- Select around a function
          ["if"] = "@function.inner",           -- Select inside a function
          ["ac"] = "@class.outer",              -- Select around a class
          ["ic"] = "@class.inner",              -- Select inside a class
        },
      },
      move = {
        enable = true,
        set_jumps = true,                       -- Set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",           -- Go to the next function start
          ["]]"] = "@class.outer",              -- Go to the next class start
        },
        goto_next_end = {
          ["]M"] = "@function.outer",           -- Go to the next function end
          ["]["] = "@class.outer",              -- Go to the next class end
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",           -- Go to the previous function start
          ["[["] = "@class.outer",              -- Go to the previous class start
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",           -- Go to the previous function end
          ["[]"] = "@class.outer",              -- Go to the previous class end
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",   -- Swap with next parameter
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",   -- Swap with previous parameter
        },
      },
    },
  }
end, 0)
