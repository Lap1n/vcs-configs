-- See :help toggleterm-roadmap
require('toggleterm').setup({
	--open_mapping = '<C-g>',
	open_mapping = '<f1>',
	direction = 'horizontal',
	shade_terminals = true
})
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
	vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
	vim.keymap.set('t', '<C-w>h', [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set('t', '<C-w>j', [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set('t', '<C-w>k', [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set('t', '<C-w>l', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
