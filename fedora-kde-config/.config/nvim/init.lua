-- Enable relative and absolute line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Set tab size to 4 spaces and use spaces instead of tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Enable automatic indentation
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.smarttab = true

-- Set colorscheme (make sure 'vim' colorscheme is available or change it)
vim.cmd("colorscheme vim")

-- Enable line wrapping
vim.opt.wrap = true

-- Enable system clipboard
vim.opt.clipboard = "unnamedplus"

-- Enable syntax highlighting (Lua equivalent)
vim.cmd("syntax enable")

-- Show line and column number in the status line
vim.opt.ruler = true

-- Highlight search results
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Enable line break on long lines
vim.opt.linebreak = true

-- Plugins with vim-plug in init.lua (still uses vim syntax for plug block)
vim.cmd [[
call plug#begin()
    " File explorer
    Plug 'preservim/nerdtree'

    " Mason and its extensions
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'neovim/nvim-lspconfig'

    " Completion framework
    Plug 'hrsh7th/nvim-cmp'

    " LSP completion source for nvim-cmp
    Plug 'hrsh7th/cmp-nvim-lsp'

    " Snippet engine and snippet source (optional but recommended)
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'

    " Buffer & path completion (optional but nice)
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
call plug#end()
]]

-- Setup Mason
require("mason").setup()

-- Optional: bridge Mason to lspconfig
require("mason-lspconfig").setup()

-- Setup LSP (example with pyright)
local lspconfig = require("lspconfig")

-- Add your preferred LSP servers here
-- Pyright setup
lspconfig.pyright.setup {
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace", -- or "openFilesOnly"
                typeCheckingMode = "basic",   -- or "basic", "strict", "off"
            }
        }
    },
    on_attach = function(client, bufnr)
        -- Optional: keymaps or buffer-local settings
        local opts = { noremap=true, silent=true }
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    end
}

-- Clangd
require('lspconfig').clangd.setup {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  cmd = { "clangd" }, -- Optional: customize if it's not in PATH
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = require('lspconfig').util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
}

-- Fortls
require('lspconfig').fortls.setup {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  cmd = { "fortls" },
  filetypes = { "fortran" },
  root_dir = require('lspconfig').util.root_pattern(".git", "."),
  -- Optional custom settings:
  settings = {
    fortran = {
      includeSymbolDetails = true,
      enableCodeActions = true,
    }
  }
}


-- Set up nvim-cmp
local cmp = require'cmp'

cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },    -- LSP suggestions
    { name = 'luasnip' },     -- Snippets
  }, {
    { name = 'buffer' },      -- Words in the buffer
    { name = 'path' },        -- Filesystem paths
  })
})


-- Fix nvim-cmp popup colors
-- vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1e1e1e", fg = "#ffffff" })          -- completion menu
vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE", fg = "#ffffff" })          -- completion menu
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#3e3e3e", fg = "#ffffff" })       -- selected item
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#2e2e2e" })                      -- scrollbar
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#5e5e5e" })                     -- scrollbar thumb

-- Remap keys
vim.keymap.set('n', '<Esc><Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
