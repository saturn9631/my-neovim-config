return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function ()
		local configure = require("nvim-treesitter.configs")
		configure.setup({
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true }
		})
	end
}
