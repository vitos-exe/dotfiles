-- init.lua --



-- Settings {{{

vim.g.mapleader = " "

vim.opt.number = true
vim.opt.wrap = false
vim.opt.foldmethod = 'marker'
vim.opt.foldlevel = 0

vim.cmd.colorscheme "vscode"

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>cb', ':bd<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader><Tab>', ':bnext<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader><S-Tab>', ':bprev<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>R', ':luafile $MYVIMRC<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>sh', ':sp<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>sv', ':vsp<CR>', opts)

vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

-- }}}



-- packer.nvim {{{

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
	use {
		'wbthomason/packer.nvim'
	}

	use {
		'nvim-treesitter/nvim-treesitter'
	}


	use {
		'nvim-telescope/telescope.nvim',
		requires = {
			'nvim-lua/plenary.nvim'
		}
	}

	use {
		'neovim/nvim-lspconfig'
	}

	use {
		'ms-jpq/coq_nvim',
		branch = 'coq',
		requires = {
			-- 9000+ Snippets
			{ 'ms-jpq/coq.artifacts',  branch = 'artifacts' },

			-- Lua & third-party sources (configure separately)
			{ 'ms-jpq/coq.thirdparty', branch = '3p' },
		},
		setup = function()
			vim.g.coq_settings = {
				auto_start = true, -- Start COQ at startup
			}
		end
	}

	-- use {
	-- 	'hrsh7th/nvim-cmp',
	-- 	requires = {
	-- 		'hrsh7th/cmp-nvim-lsp',
	-- 		'hrsh7th/cmp-buffer',
	-- 		'hrsh7th/cmp-path',
	-- 	}
	-- }

	use {
		'nvim-tree/nvim-web-devicons'
	}

	use {
		'nvim-lualine/lualine.nvim',
	}

	use {
		'lewis6991/gitsigns.nvim'
	}

	use {
		'tpope/vim-commentary'
	}

	use {
		'andymass/vim-matchup',
	}

	use {
		'windwp/nvim-autopairs',
	}

	use {
		'Mofiqul/vscode.nvim'
	}

	if packer_bootstrap then
		require('packer').sync()
	end
end)

-- }}}



-- nvim-treesitter {{{

require 'nvim-treesitter.configs'.setup {
	highlight = { enable = true },
	indent = { enable = true }
}

-- }}}



-- telescope.nvim {{{

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = 'Telescope find marks' })
vim.keymap.set('n', '<leader>fp', builtin.planets, { desc = 'Telescope list planets' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope list keymaps' })
vim.keymap.set('n', '<leader>fc', builtin.git_commits, { desc = 'Telescope find git commits' })
vim.keymap.set('n', '<leader>d', builtin.diagnostics, { desc = 'Telescope diagnostics' })

-- }}}



-- nvim-cmp {{{

-- local cmp = require 'cmp'
-- cmp.setup({
-- 	window = {
-- 		completion = cmp.config.window.bordered(),
-- 		documentation = cmp.config.window.bordered(),
-- 	},
-- 	mapping = {
-- 		['<C-Space>'] = cmp.mapping.complete(),
-- 		['<C-e>'] = cmp.mapping.close(),
-- 		['<CR>'] = cmp.mapping.confirm({ select = true }),
-- 		['<Tab>'] = cmp.mapping.select_next_item(),
-- 		['<S-Tab>'] = cmp.mapping.select_prev_item(),
-- 	},
-- 	sources = cmp.config.sources({
-- 		{ name = 'nvim_lsp' },
-- 		{ name = 'path' },
-- 		{ name = 'buffer' }
-- 	})
-- })

-- }}}



-- nvim-lspconfig {{{

local lspconfig = require('lspconfig')
local coq = require('coq')
local language_servers = { 'jsonls', 'ts_ls', 'pyright', 'angularls', 'cssls', 'html', 'lua_ls' }
for _, value in ipairs(language_servers) do
	lspconfig[value].setup { coq.lsp_ensure_capabilities() }
end

-- }}}



-- lualine.nvim {{{

require('lualine').setup()

-- }}}



-- gitsigns.nvim {{{

require('gitsigns').setup()

-- }}}



-- nvim-autopairs {{{

require('nvim-autopairs').setup()

-- }}}
