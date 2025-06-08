-- See `:help vim.lsp.*` for documentation on any of the below commands
local keymap = {
	{ key = "gd", command = vim.lsp.buf.definition },
	{ key = "gD", command = vim.lsp.buf.declaration },
	{ key = "<F12>", command = vim.lsp.buf.definition },

	{ key = "<F2>", command = vim.lsp.buf.rename },

	{ key = "K", command = vim.lsp.buf.hover },
	{ key = "<C-K>", command = vim.lsp.buf.code_action },
	{ key = "<C-.>", command = vim.lsp.buf.code_action },
}

local nvim_command = vim.api.nvim_command

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- only show error dialogs after 600 ms
    vim.cmd "set updatetime=600"

    -- TODO: there is a bug where when the diagnostic window opens, it automatically
    -- receives focus. This is undesired, so I have tempoarily disabled it
    -- if you want to see an error, use the F8 key
    -- nvim_command("autocmd CursorHold <buffer> lua vim.diagnostic.open_float({ nil, { focusable = false } })")

    local opts = { buffer = ev.buf }
	for _, v in ipairs(keymap) do
	    vim.keymap.set("n", v.key, v.command, opts)
	end

	-- by default, GuessIndent will echo back the indent level
	-- I use the "silent" command so that the output is not printed
	vim.cmd "silent GuessIndent"
    end,
})
