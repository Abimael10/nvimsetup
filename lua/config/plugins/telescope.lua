return {
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
	--Find help - fh
	vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)

	--Find directory - fd
	vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files)

	--Show the config files of my NEOVIM setup
	vim.keymap.set("n", "<space>en", function()
	    require('telescope.builtin').find_files {
		cwd = vim.fn.stdpath("config")
	    }
	end
	)
    end
    }
}
