return {
	{
		'kdheepak/lazygit.nvim',
		cmd = 'LazyGit',
		keys = {
			{
				';c', -- Change this to whatever you prefer
				'<cmd>LazyGit<CR>',
				desc = 'Open LazyGit',
				mode = { 'n' },
				silent = true,
				noremap = true,
			},
		},
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('lualine').setup {
				options = {
					icons_enabled = true,
					theme = 'auto',
					component_separators = { left = '', right = '' },
					section_separators = { left = '', right = '' },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					always_show_tabline = true,
					globalstatus = true,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
						refresh_time = 16, -- ~60fps
						events = {
							'WinEnter',
							'BufEnter',
							'BufWritePost',
							'SessionLoadPost',
							'FileChangedShellPost',
							'VimResized',
							'Filetype',
							'CursorMoved',
							'CursorMovedI',
							'ModeChanged',
						},
					},
				},
				sections = {
					lualine_a = { 'mode' },
					lualine_b = { 'branch', 'diff', 'diagnostics' },
					lualine_c = { { 'filename', path = 2 } },
					lualine_x = {
						function()
							return os.date '%I:%M %p' -- e.g., 04:32 PM
						end,
					},
					lualine_y = { 'lsp_status' },
					lualine_z = { 'location' },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { 'filename' },
					lualine_x = { 'location' },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			}
		end,
	},
	-- lazy.nvim

	{
		'folke/noice.nvim',
		opts = {
			presets = {}, -- no preset UIs except what you enable
			cmdline = { enabled = false },
			messages = { enabled = false },
			popupmenu = { enabled = false },
			notify = { enabled = false },
			lsp = {
				progress = { enabled = false },
				hover = { enabled = true }, -- still allow hover
				signature = { enabled = true }, -- still allow signature help
				documentation = {
					view = 'hover',
					opts = {
						keys = {
							scroll_down = '<C-f>',
							scroll_up = '<C-b>',
						},
						border = { style = 'rounded' },
						max_width = 80,
						max_height = 20,
						position = {
							row = 2, -- move 1 line down
							col = 4, -- move 2 columns right
						},
					},
				},
			},
		},
	},
}
