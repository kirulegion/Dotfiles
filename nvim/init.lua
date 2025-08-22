require 'config.config'
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
	if vim.v.shell_error ~= 0 then
		error('Error cloning lazy.nvim:\n' .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)
require('lazy').setup {
	'NMAC427/guess-indent.nvim', -- simple string plugin
	{ import = 'config.plugins' }, -- import from folder

	{                        -- gitsigns as a plugin table
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '✚' },
				change = { text = '~' },
				delete = { text = '•' }, -- bullet dot symbol
				topdelete = { text = '•' },
				changedelete = { text = '~' },
			},
		},
	},
}
