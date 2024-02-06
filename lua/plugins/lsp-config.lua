return {
    -- LSP Configuration & Plugins
	'neovim/nvim-lspconfig',
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		{ 'williamboman/mason.nvim',
			config = true },
		{'williamboman/mason-lspconfig.nvim'},

		-- Useful status updates for LSP
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ 'j-hui/fidget.nvim'},

		-- Additional lua configuration, makes nvim stuff amazing!
		{'folke/neodev.nvim'},
	},
	config = function()
		local lspconfig = require("lspconfig")
		lspconfig.lua_ls.setup({})
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
		vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
	end
  }
