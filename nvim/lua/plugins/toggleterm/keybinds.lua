local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _Lazygit_toggle()
  lazygit:toggle()
end

Keybind.register_which_key_keybinds({
  g ={'<cmd>lua _Lazygit_toggle()<CR>','Move to word'},
}, { prefix = "<leader>" })

Keybind.g({
	{ 'n', '<F2>', '<cmd>ToggleTerm<CR>', { noremap = false, silent = true } },
})