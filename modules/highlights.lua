-- used to highlight certain words in different colours
-- eg. I want to highlight todos and conform to the better comments standard

vim.cmd "hi TodoColor ctermbg=205 guibg=#FF8C00 guifg=black ctermfg=black"
vim.cmd "hi AlertColor ctermbg=205 guibg=#FF2D00 guifg=black ctermfg=black"
vim.cmd "hi InfoColor ctermbg=205 guibg=#3498DB guifg=black ctermfg=black"

function AddHighlights()
	vim.fn.matchadd("TodoColor", "TODO")
	vim.fn.matchadd("TodoColor", "TODO:")

	vim.fn.matchadd("AlertColor", "//!")
	vim.fn.matchadd("AlertColor", "--!")

	vim.fn.matchadd("InfoColor", "//?")
	vim.fn.matchadd("InfoColor", "--?")
end

vim.cmd("autocmd BufRead * lua AddHighlights()")
vim.cmd("autocmd WinEnter * lua AddHighlights()")
