return {
    {
	"neovim/nvim-lspconfig",
	dependencies = {'saghen/blink.cmp'},
	config = function()
	    local capabilities = require('blink.cmp').get_lsp_capabilities()
	    require("lspconfig").rust_analyzer.setup {capabilities = capabilitiesa}
	    --require("lspconfig").lua_ls.setup {capabilities = capabilities}
	end,
    }
}
