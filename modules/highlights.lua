-- used to highlight certain words in different colours
-- eg. I want to highlight todos and conform to the better comments standard

-- Conforms to the better-comments format by aaron bond
-- Under the MIT license
function AddHighlights()
	vim.fn.clearmatches()

	vim.api.nvim_set_hl(0, "TodoColor", {
		bg = "#FF8C00", -- guibg
		fg = "black",   -- guifg
		ctermbg = 205,  -- ctermbg
		ctermfg = 16,   -- ctermfg (16 is typically black in 256-color terminals)
	})

	vim.api.nvim_set_hl(0, "AlertColor", {
		bg = "#FF2D00",
		fg = "black",
		ctermbg = 205,
		ctermfg = 16,
	})

	vim.api.nvim_set_hl(0, "InfoColor", {
		bg = "#3498DB",
		fg = "black",
		ctermbg = 205,
		ctermfg = 16,
	})

	vim.api.nvim_set_hl(0, "ImportantColor", {
		bg = "#98C379",
		fg = "black",
		ctermbg = 205,
		ctermfg = 16,
	})

	vim.fn.matchadd("TodoColor", "TODO")
	vim.fn.matchadd("TodoColor", "TODO:")

	vim.fn.matchadd("AlertColor", "//!")
	vim.fn.matchadd("AlertColor", "--!")

	vim.fn.matchadd("InfoColor", "//?")
	vim.fn.matchadd("InfoColor", "--?")

	--vim.fn.matchadd("ImporantColor", "//\*")
	--vim.fn.matchadd("ImporantColor", "--\*")
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = AddHighlights })
vim.api.nvim_create_autocmd("BufRead", { callback = AddHighlights })
vim.api.nvim_create_autocmd("WinEnter", { callback = AddHighlights })
