return {
	'neovim/nvim-lspconfig',
	dependencies = { 'saghen/blink.cmp'},
	config = function()
		local lspconfig = require('lspconfig')
		local capabilities = require('blink.cmp').get_lsp_capabilities()
		local language_servers = { 'jsonls', 'ts_ls', 'pyright', 'angularls', 'cssls', 'html', 'lua_ls' }
		for _, value in ipairs(language_servers) do
			lspconfig[value].setup { capabilities = capabilities }
		end

		require'lspconfig'.java_language_server.setup{
			cmd = {'/Users/vitalii.chernysh/scratch/java-language-server/dist/lang_server_mac.sh'}
		}

		local opts = { noremap = true, silent = true }
		vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
		vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
		vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
		vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
		vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
		vim.api.nvim_set_keymap('n', '<leader>o', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
	end
}

