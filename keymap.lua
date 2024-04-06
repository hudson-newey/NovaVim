-- TODO: change this to an array of objects
local keymap = {
	{ key = "C-P", command = "Telescope find_files" },
	{ key = "C-SP", command = "Telescope commands" },

	{ key = "C-O", command = "Telescope Projects" },

	{ key = "C-B", command = "NvimTreeToggle" },
	{ key = "CS-E", command = "NvimTreeToggle" },

	{ key = "C-F", command = "Telescope search_history" },
	{ key = "CS-F", command = "Telescope live_grep" },

	{ key = "CS-X", command = "Mason" },

	{ key = "C-S", command = "w" },
	{ key = "C-Z", command = "undo" },
	{ key = "CS-Z", command = "redo" },

	{ key = "C-\\", command = "vs" },

	{ key = "C-TAB", command = "BufferNext" },
	{ key = "CS-TAB", command = "BufferPrevious" },

	{ key = "C-Q", command = "BufferClose" },

	{ key = "C-]", command = "BufferNext" },
	{ key = "CS-]", command = "BufferPrevious" },
	{ key = "C-Q", command = "BufferClose" },
	{ key = "C-j", command = "lua require('nvterm.terminal').toggle 'horizontal'" },
}

for _, v in ipairs(keymap) do
	vim.api.nvim_set_keymap("n", "<" .. v.key .. ">", ":" .. v.command .. "<CR>", { noremap = true, silent = true })
end

vim.cmd "vnoremap < <gv"
vim.cmd "vnoremap > >gv"
