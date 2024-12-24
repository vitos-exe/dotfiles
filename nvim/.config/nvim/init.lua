-- init.lua --



-- Settings {{{

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.wrap = false
vim.opt.foldmethod = 'marker'
vim.opt.foldlevel = 0

-- vim.cmd.colorscheme "vscode"

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



-- lazy.nvim {{{

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {

		-- Treesitter for syntax highlighting
		{ "nvim-treesitter/nvim-treesitter" },

		-- Telescope for fuzzy finding
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
		},

		-- LSP configurations
		{ "neovim/nvim-lspconfig" },

		-- Autocompletion plugins
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
		},

		-- Filetype icons
		{ "nvim-tree/nvim-web-devicons" },

		-- Statusline plugin
		{ "nvim-lualine/lualine.nvim" },

		-- Git integration
		{ "lewis6991/gitsigns.nvim" },

		-- Commenting utility
		{ "tpope/vim-commentary" },

		-- Enhanced % matching
		{ "andymass/vim-matchup" },

		-- -- Auto pair insertion
		{ "windwp/nvim-autopairs" },

		-- VS Code-like colorscheme
		{
			"Mofiqul/vscode.nvim",
			lazy = false,
			config = function()
				vim.cmd.colorscheme 'vscode'
			end,
		},
	},
})

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

local cmp = require 'cmp'
cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = {
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'path' },
		{ name = 'buffer' }
	})
})

-- }}}



-- nvim-lspconfig {{{

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local language_servers = { 'jsonls', 'ts_ls', 'pyright', 'angularls', 'cssls', 'html', 'lua_ls' }
for _, value in ipairs(language_servers) do
	lspconfig[value].setup { capabilities = capabilities }
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
