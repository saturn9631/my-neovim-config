return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function ()
		local configure = require("nvim-treesitter.configs")
		configure.setup({
			ensure_installed = {"lua"},
			highlight = { enable = true },
			indent = { enable = true }
		})
	end
}
