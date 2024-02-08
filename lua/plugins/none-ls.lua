return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				--To get formmatting, diagnostic, and completion use builtin.*tool*.*tool name*,
			}
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end
}
