return {
	{"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function ()
			local configure = require("nvim-treesitter.configs")
			configure.setup({
				auto_install = true,
				highlight = { eneble = true },
				indent = { enable = true }
			})
		end
	},

	{"neovim/nvim-lspconfig",
		dependencies = {
				{"williamboman/mason.nvim",
					config = function()
						require("mason").setup()
					end
				},
				{"williamboman/mason-lspconfig.nvim",
					config = function()
						require("mason-lspconfig").setup ({
							ensure_installed = {"lua_ls", "nil_ls"}
						})
					end
				}

		},
		config = function ()
			local lspconfig = require ("lspconfig")
			--lsp configurations: lspconfig."lsp_name".setup({})
			lspconfig.lua_ls.setup ({})
			lspconfig.nil_ls.setup ({})
			lspconfig.pylsp.setup ({})
			lspconfig.rust.setup ({})
			lspconfig.tombi.setup ({})
			lspconfig.asm_lsp.setup ({})

			--vim keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end
	},
	{"nvimtools/none-ls.nvim",
		config = function ()
			local null_ls = require("null-ls")
			null_ls.setup ({
				sources = {
					--To get formmatting, diagnostics (linters), and completion use null_ls.builtins.*tool*.*tool name*,
					null_ls.builtins.formatting.nixpkgs_fmt,
					null_ls.builtins.formatting.black,
					null_ls.builtins.diagnostics.pylint,
					null_ls.builtins.formatting.tombi,
					null_ls.builtins.diagnostics.tombi,
					null_ls.builtins.diagnostics.rust,

				}
			})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end
	},
	{"mfussenegger/nvim-dap",
		dependencies = {"rcarriga/nvim-dap-ui"},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			eqp.listeners.before.attach.dapui_config = function ()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function ()
				dapui.open()
			end
			dap.listeners.befor.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
			vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<leader>dc", dap.continue, {})
		end
	},
	{"L3MON4D3/LuaSnip",
		dependencies = {"saadparwaiz1/cmp_luasnip",
				"rafamadriz/friendly-snippets"}
	},
	{"hrsh7th/nvim-cmp",
		dependencies = {"hrsh7th/cmp-nvim-lsp"},
	-- Set up nvim-cmp.
		config = function()
			local cmp = require('cmp')
			require("luasnip.loaders.from_vscode").lazy_load()
				cmp.setup({
					snippet = {
						-- REQUIRED - you must specify a snippet engine
						expand = function(args)
							--vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
							require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
							-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
							-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
						end,
					},
					window = {
						completion = cmp.config.window.bordered(),
						documentation = cmp.config.window.bordered(),
					},
					mapping = cmp.mapping.preset.insert({
						['<C-b>'] = cmp.mapping.scroll_docs(-4),
						['<C-f>'] = cmp.mapping.scroll_docs(4),
						['<C-Space>'] = cmp.mapping.complete(),
						['<C-e>'] = cmp.mapping.abort(),
						['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					}),
					sources = cmp.config.sources({
						{ name = 'nvim_lsp' },
						--{ name = 'vsnip' }, -- For vsnip users.
						{ name = 'luasnip' }, -- For luasnip users.
						-- { name = 'ultisnips' }, -- For ultisnips users.
						-- { name = 'snippy' }, -- For snippy users.
					}, {
						{ name = 'buffer' },
					})
				})
		end
	}
}
