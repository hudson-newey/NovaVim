-- by default neovim has the definition of a function at the top of the buffer
-- I don't like this functionality and want it so that when i goto definition
-- the definition source is in the center of the screen

function goto_handler()
	vim.cmd "normal zz"
end

local util = require 'vim.lsp.util'
local params = util.make_position_params()
local results, err = vim.lsp.buf_request_sync(0, 'textDocument/definition', params, 1000)
if results then
	for client_id, result in pairs(results) do
		goto_handler()
	end
end
