-- Tab / Indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.smartindent = true

-- Search
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false

-- Appearance
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.termguicolors = true
vim.wo.colorcolumn = '100'
vim.wo.signcolumn = 'yes'
vim.o.cmdheight = 1
vim.wo.scrolloff = 10
vim.o.completeopt = 'menuone,noinsert,noselect'

-- Behaviour
vim.o.hidden = true
vim.o.errorbells = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.expand("~/.vim/undodir")
vim.o.undofile = true
vim.o.backspace = "indent,eol,start"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.autochdir = false
vim.opt.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.bo.modifiable = true
vim.o.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.o.encoding = "UTF-8"

vim.o.breakindent = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Highlight text on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", {clear = true})
vim.api.nvim_create_autocmd(
    "TextYankPost",
    {
        callback = function()
            vim.highlight.on_yank()
        end,
        group = highlight_group,
        pattern = "*"
    }
)
