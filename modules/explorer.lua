local lastUsedFile = ""

function RevealFileInExplorer()
	local currentFile = expand("%:t")

	if currentFile ~= nil and currentFile ~= lastUsedFile then
		--vim.cmd "Neotree reveal"
		lastUsedFile = currentFile
	end
end

-- If you open a buffer to the left of the explorer tree
-- It will move around to unexpected position
-- to make it static, we toggle the explorer twice
function RepositionExplorer()
	vim.cmd ":Neotree toggle<CR>"
	vim.cmd ":Neotree toggle<CR>"
end

-- TODO: Fix
--vim.cmd("autocmd BufRead * lua RepositionExplorer()")
