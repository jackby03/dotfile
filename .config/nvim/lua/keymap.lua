-- Configuración básica
vim.opt.number = true -- Mostrar números de línea
vim.opt.relativenumber = true -- Números relativos
vim.opt.tabstop = 2 -- Espacios por tabulación
vim.opt.shiftwidth = 2 -- Espacios en identación
vim.opt.expandtab = true -- Convierte tabs en espacios
vim.opt.smartindent = true -- Indentado inteligente
vim.opt.termguicolors = true -- Habilitar colores en la terminal
vim.opt.cursorline = true -- Resaltar línea actual
vim.opt.background = "dark" -- Fondo oscuro
vim.opt.clipboard = "unnamedplus" -- Utiliza el portapapeles del sistema

-- Atajos de teclado básicos
vim.g.mapleader = " " -- Leader map
vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>x", ":x<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })
