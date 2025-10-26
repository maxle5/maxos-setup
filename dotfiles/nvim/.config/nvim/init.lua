-- [[ Options ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.wrap = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

vim.schedule(function()
	vim.o.clipboard = 'unnamedplus'
end)

-- [[ Keymaps ]]
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "gd", "vim.lsp.buf.type_definition")
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		vim.keymap.set("n", "gd", vim.lsp.buf.type_definition, { buffer = args.buf })
		vim.keymap.set("n", "cf", vim.lsp.buf.format, { buffer = args.buf })
	end,
})

-- [[ LSP ]]
vim.lsp.config('vtsls', {
	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
})
vim.lsp.enable('vue_ls')
vim.lsp.enable('vtsls')
vim.lsp.enable('lua_ls')
-- vim.lsp.enable('roslyn_ls')

-- [[ Plugins ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
	if vim.v.shell_error ~= 0 then
		error('Error cloning lazy.nvim:\n' .. out)
	end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	-- Color Theme
	{
		'sainnhe/gruvbox-material',
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_enable_italic = true
			vim.g.gruvbox_material_background = 'hard'
			vim.cmd.colorscheme 'gruvbox-material'
		end,
	},

	-- Code highlighting
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		main = 'nvim-treesitter.configs',
		opts = {
			ensure_installed = { 'lua' },
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = { enable = true },
		},
	},

	-- Search
	{
		'nvim-telescope/telescope.nvim',
		event = 'VimEnter',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
			{ 'nvim-telescope/telescope-ui-select.nvim' },
			{ 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
		},
		config = function()
			require('telescope').setup {
				extensions = {
					['ui-select'] = {
						require('telescope.themes').get_dropdown(),
					},
				},
			 	defaults = {
					vimgrep_arguments = {
					  'rg',
					  '--color=never',
					  '--no-heading',
					  '--with-filename',
					  '--line-number',
					  '--column',
					  '--smart-case'   -- <== important
					},
				}
			}

			pcall(require('telescope').load_extension, 'fzf')
			pcall(require('telescope').load_extension, 'ui-select')

			local builtin = require 'telescope.builtin'
			local utils = require 'telescope.utils'

			vim.keymap.set('n', '<C-p>', function()
				builtin.find_files({ hidden = true })
			end)
			vim.keymap.set('n', '<C-S-f>', builtin.live_grep)
			vim.keymap.set('n', '<C-f>', function()
				builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
					winblend = 10,
					previewer = false,
				})
			end)
		end,
	},

	-- Git
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
		},
	},

	{ "neovim/nvim-lspconfig" },

	-- Autoformat
	{},
})
