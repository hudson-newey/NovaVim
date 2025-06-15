-- used to highlight certain words in different colours
-- eg. I want to highlight todos and conform to the better comments standard

local function register_comment_highlight(name, keyword)
	local matcher_prefixes = { "//", "--" }

	for _, value in ipairs(matcher_prefixes) do
		vim.fn.matchadd(name, value .. keyword .. ".*")
		vim.fn.matchadd(name, value .. " " .. keyword .. ".*")
	end
end

-- Conforms to the better-comments format by aaron bond
-- Under the MIT license
local function add_highlights()
	vim.fn.clearmatches()

	vim.api.nvim_set_hl(0, "TodoColor", {
		bg = "black",   -- guifg
		fg = "#FF8C00", -- guibg
		ctermbg = 205,  -- ctermbg
		ctermfg = 16,   -- ctermfg (16 is typically black in 256-color terminals)
	})

	vim.api.nvim_set_hl(0, "AlertColor", {
		bg = "black",
		fg = "#FF2D00",
		ctermbg = 205,
		ctermfg = 16,
	})

	vim.api.nvim_set_hl(0, "InfoColor", {
		bg = "black",
		fg = "#3498DB",
		ctermbg = 205,
		ctermfg = 16,
	})

	vim.api.nvim_set_hl(0, "ImportantColor", {
		bg = "black",
		fg = "#98C379",
		ctermbg = 205,
		ctermfg = 16,
	})

	register_comment_highlight("TodoColor", "TODO")
	register_comment_highlight("AlertColor", "!")
	register_comment_highlight("InfoColor", "?")
	-- register_highlights("ImporantColor", "\\*")
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = add_highlights })
vim.api.nvim_create_autocmd("BufRead", { callback = add_highlights })
vim.api.nvim_create_autocmd("WinEnter", { callback = add_highlights })
