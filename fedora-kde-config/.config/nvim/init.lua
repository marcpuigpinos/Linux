-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Set colorscheme (make sure 'vim' colorscheme is available or change it)
vim.cmd("colorscheme vim")

-- Fix nvim-cmp popup colors
-- vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1e1e1e", fg = "#ffffff" })          -- completion menu
vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE", fg = "#ffffff" }) -- completion menu
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#3e3e3e", fg = "#ffffff" }) -- selected item
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#2e2e2e" }) -- scrollbar
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#5e5e5e" }) -- scrollbar thumb
