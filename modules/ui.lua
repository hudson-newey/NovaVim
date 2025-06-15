local config = require("config")

if config.dark_mode then
  vim.o.background = "dark"
else
  vim.o.background = "light"
end

vim.cmd ("colorscheme " .. config.colorscheme)
vim.opt.termguicolors = true

-- by using laststatus=3 there will be a global status bar across all
-- panes similar to vscode
vim.opt.laststatus = 3

-- set rulers
vim.cmd "let &colorcolumn='80,120'"

-- enable line numbers
vim.cmd "set nu"

-- make the cursor blink
-- This command looks really complex because we have to support different modes
--
-- See the following stack overflow answer to see where I got this from
-- https://stackoverflow.com/a/63924002
-- vim.cmd "set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

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

-- Neovim renders certain text inside the text editor as bold/italic
-- e.g. if the output html looks bold or italic
-- I have disabled it because it looks like an error and which confuses me
vim.cmd "let html_no_rendering=1"
