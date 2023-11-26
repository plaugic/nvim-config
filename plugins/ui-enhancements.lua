-- plugins/treesitter.lua
-- Configuration for nvim-treesitter

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = "all", 

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,              

    -- List of language that will be disabled
    -- disable = { "c", "rust", },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  -- Add more configurations here, like indentation, textobjects, etc.
}

-- You may add more Treesitter related configurations or custom setups here

