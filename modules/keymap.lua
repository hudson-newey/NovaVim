function ToggleNeoTree()
	vim.cmd "Neotree toggle"
	vim.cmd "wincmd ="
end
vim.api.nvim_create_user_command(
	"ToggleNeoTree",
	ToggleNeoTree,
	{}
)

function OpenSidebar()
	local focusedWindowNumber = vim.fn.winnr()

	vim.cmd "ToggleNeoTree"

	-- re-focus the original window
	-- local windows = vim.api.nvim_list_wins()
	-- vim.api.nvim_set_current_win(focusedWindowNumber)
end
vim.api.nvim_create_user_command(
	"OpenSidebar",
	OpenSidebar,
	{}
)

function RevealNeoTree()
	vim.cmd "Neotree reveal"
	vim.cmd "wincmd ="
end
vim.api.nvim_create_user_command(
	"RevealNeoTree",
	RevealNeoTree,
	{}
)

local keymap = {
	{ key = "<C-P>", command = "Telescope find_files" },
	{ key = "<CS-P>", command = "Telescope commands" },

	{ key = "<C-O>", command = "Telescope projects" },

	{ key = "<CS-O>", command = "Telescope lsp_document_symbols" },

	{ key = "<C-B>", command = "OpenSidebar", insert = true },
	{ key = "<CS-E>", command = "RevealNeoTree", insert = true },

	{ key = "<C-F>", command = "Telescope current_buffer_fuzzy_find" },
	{ key = "<CS-F>", command = "Telescope live_grep" },

	{ key = "<CS-X>", command = "Mason" },

	{ key = "<C-S>", command = "w", insert = true },
	{ key = "<C-Z>", command = "undo", insert = true },
	{ key = "<CS-Z>", command = "redo", insert = true },

	{ key = "<C-\\>", command = "vs | wincmd l", insert = true },
	{ key = "<CS-\\>", command = "split | wincmd j", insert = true },

	{ key = "<C-TAB>", command = "BufferNext" },
	{ key = "<CS-TAB>", command = "BufferPrevious" },

	{ key = "<ESC>", command = "noh" },

	{ key = "<C-Q>", command = "BufferClose" },

	{ key = "<C-]>", command = "BufferNext" },
	{ key = "<CS-]>", command = "BufferPrevious" },
	{ key = "<CS-Q>", command = "BufferClose" },

	{ key = "<C-j>", command = "lua require('nvterm.terminal').toggle 'horizontal'" },
	{ key = "<C-`>", command = "lua require('nvterm.terminal').toggle 'horizontal'" },
	{ key = "<CS-`>", command = "lua require('nvterm.terminal').toggle 'horizontal'" },

	{ key = "<C-/>", command = "CommentToggle" },

	{ key = "<C-\\->", command = "wincmd =" },
	{ key = "<C-+>", command = "wincmd =" },
	{ key = "<C-0>", command = "wincmd =" },

	{ key = "<AS-F>", command = "Neoformat" },

	-- make it so that when you jump to a mark it centers the result
	{ key = "<'>-<'>", command = "normal ''zz" }
}

for _, v in ipairs(keymap) do
	vim.api.nvim_set_keymap("n", v.key, ":silent " .. v.command .. "<CR>", { noremap = true, silent = true })

	if v.insert then
		-- exit insert mode, execute the command, then return to insert mode
		vim.api.nvim_set_keymap("i", v.key, "<ESC>:silent " .. v.command .. "<CR>i", { noremap = true, silent = true })
	end
end

vim.cmd "vnoremap < <gv"
vim.cmd "vnoremap > >gv"

-- I remap Ctrl+D to Ctrl+N because the multi word select extension default to Ctrl+N
-- This is not what I like, therefore, I"ve rebinded it to Ctrl+D (same as VsCode and Sublime Text)
vim.cmd "nnoremap <C-d> <C-n>"

-- map tab to a tab completion so that I can press tab to complete an auto
-- complete query
vim.cmd "inoremap <expr> <TAB> pumvisible() ? '<C-y>' : '<TAB>'"

-- in alacritty, you are not able to overwrite ctrl + shift + F
-- to fix this, I have seen a hacky stack overflow solution that prints invisible unicode characters
-- and uses that as a signal to trigger the ctrl + shift + F shortcut
-- see: https://stackoverflow.com/a/78694090
vim.keymap.set("n", "♠", ":Telescope live_grep<CR>")
