vim.opt.termguicolors = true

---- change this to background=light if you want light mode
vim.cmd "set background=dark"

vim.cmd "colorscheme vscode"

-- by using laststatus=3 there will be a global status bar across all
-- panes similar to vscode
vim.cmd "set laststatus=3"

-- set rulers
vim.cmd "let &colorcolumn='80,120'"

-- enable line numbers
vim.cmd "set nu"

-- disable line wrapping
-- this is a controversial change, but I have made it because it keeps in line
-- with the same defaults that vscode has
vim.wo.wrap = false

-- show trailing whitespace
-- TODO: This isn"t currently working with indent-blankline
-- vim.cmd "set list"
-- vim.cmd "set listchars=trail:·,tab:>-"

-- "fix" vertical split because I didn"t like how it worked
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

-- for some reason Neovim decides that it should render certain text inside the
-- text editor as bold/italic e.g. if the output html looks bold or italic
-- I have disabled it because it looks like an error, and HTML is not used for
-- styling, so it is semantically incorrect
vim.cmd "let html_no_rendering=1"
