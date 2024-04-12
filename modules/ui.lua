-- change this to background=light if you want light mode
vim.cmd "set background=dark"

vim.cmd "colorscheme vscode"

-- set rulers
vim.cmd "let &colorcolumn='80,120'"

-- enable line numbers
vim.cmd "set nu"

-- show trailing whitespace
-- TODO: This isn't currently working with indent-blankline
-- vim.cmd "set list"
-- vim.cmd "set listchars=trail:·,tab:>-"

-- "fix" vertical split because I didn't like how it worked
vim.cmd "vertical resize +10"

-- colorschemes I like
-- vim.cmd "colorscheme material-darker"
-- vim.cmd "colorscheme slate"

-- TODO: Find a more reliable minimap that works with split buffers, make my own
-- or fix the current Minimap plugin
--[=====[
vim.cmd[[
  augroup CustomCommands
    autocmd!
    autocmd BufReadPost * lua vim.cmd "Minimap"
  augroup END
  ]]
--]=====]
