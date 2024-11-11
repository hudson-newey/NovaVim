-- See `:help vim.lsp.*` for documentation on any of the below commands
local keymap = {
	{ key = "gd", command = vim.lsp.buf.definition },
	{ key = "<F12>", command = vim.lsp.buf.definition },

	{ key = "<F2>", command = vim.lsp.buf.rename },

	{ key = "K", command = vim.lsp.buf.hover },
	{ key = "<C-K>", command = vim.lsp.buf.code_action },
	{ key = "<C-.>", command = vim.lsp.buf.code_action },
}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf }
	for _, v in ipairs(keymap) do
	    vim.keymap.set("n", v.key, v.command, opts)
	end

	-- by default, GuessIndent will echo back the indent level
	-- I use the "silent" command so that the output is not printed
	vim.cmd "silent GuessIndent"
    end,
})
