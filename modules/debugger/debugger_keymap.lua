local keymap = {
	{ key = "<F5>", command = "DapContinue" },
	{ key = "<S-F5>", command = "lua require('dap').close()" },
	{ key = "<C-S-F5>", command = "lua require('dap').restart()" },
	{ key = "<F6>", command = "DapPause" },
	{ key = "<F6>", command = "DapPause" },
	{ key = "<F9>", command = "DapToggleBreakpoint" },
	{ key = "<F10>", command = "DapStepOver" },
	{ key = "<F11>", command = "DapStepInto" },
	{ key = "<S-F11>", command = "DapStepOut" },
}

for _, v in ipairs(keymap) do
	vim.api.nvim_set_keymap("n", v.key, ":" .. v.command .. "<CR>", { noremap = true })
end
