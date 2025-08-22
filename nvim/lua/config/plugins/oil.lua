return {
	'stevearc/oil.nvim',
	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},
	lazy = false,
	opts = {
		default_file_explorer = true,
		columns = {
			'icon',
		},
		view_options = {
			show_hidden = false,
		},
	},
	keys = {
		{ '-', '<CMD>Oil<CR>', desc = 'Open parent directory (Oil)' },
	},
}
