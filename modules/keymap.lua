local keymap = {
	{ key = "C-P", command = "Telescope find_files" },
	{ key = "CS-P", command = "Telescope commands" },

	{ key = "C-O", command = "Telescope projects" },

	{ key = "C-B", command = "Neotree toggle" },
	{ key = "CS-E", command = "Neotree reveal" },

	{ key = "C-F", command = "Telescope search_history" },
	{ key = "CS-F", command = "Telescope live_grep" },

	{ key = "CS-X", command = "Mason" },

	{ key = "C-S", command = "w" },
	{ key = "C-Z", command = "undo" },
	{ key = "CS-Z", command = "redo" },

	{ key = "C-\\", command = "vs" },
	{ key = "CS-\\", command = "split" },

	{ key = "C-TAB", command = "BufferNext" },
	{ key = "CS-TAB", command = "BufferPrevious" },

	{ key = "ESC", command = "noh" },

	{ key = "C-Q", command = "BufferClose" },

	{ key = "C-]", command = "BufferNext" },
	{ key = "CS-]", command = "BufferPrevious" },
	{ key = "C-Q", command = "BufferClose" },

	{ key = "C-j", command = "lua require('nvterm.terminal').toggle 'horizontal'" },
	{ key = "C-`", command = "lua require('nvterm.terminal').toggle 'horizontal'" },
	{ key = "CS-`", command = "lua require('nvterm.terminal').toggle 'horizontal'" },
}

for _, v in ipairs(keymap) do
	vim.api.nvim_set_keymap("n", "<" .. v.key .. ">", ":" .. v.command .. "<CR>", { noremap = true, silent = true })
end

vim.cmd "vnoremap < <gv"
vim.cmd "vnoremap > >gv"

-- I remap Ctrl+D to Ctrl+N because the multi word select extension default to Ctrl+N
-- This is not what I like, therefore, I"ve rebinded it to Ctrl+D (same as VsCode and Sublime Text)
vim.cmd "nnoremap <C-d> <C-n>"
