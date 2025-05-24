-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- lsp configuration: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--
require("lspconfig").fortls.setup({})

-- vim options
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
