return {
    	-- LSP Configuration & Plugins
	{'neovim/nvim-lspconfig',
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		{ 'williamboman/mason.nvim',
			config = true },
		{'williamboman/mason-lspconfig.nvim',
			config = function()
				require("mason-lspconfig").setup({
						--To make sure that ceratain luanguage servers are installed use ensure_installed = {*server*}
				})
			end},

		-- Useful status updates for LSP
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ 'j-hui/fidget.nvim', opts = {}},

		-- Additional lua configuration, makes nvim stuff amazing!
		{'folke/neodev.nvim'},
	},
	config = function()
		local lspconfig = require("lspconfig")
		--to setup language servers use lspconfig.*server*.setup({})
		--lspconfig.python-lsp-server.setup({}) --Causes Regression
		--lspconfig..setup({}) --Causes Regression
		--This Seems inefficient, find out if there is a way to get a list of installed lsp seervers and call there setup function.
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
		vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
	end}
	
}
