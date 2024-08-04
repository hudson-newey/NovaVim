-- This file contains all the custom commands that can be run
-- most of these commands exist so that the command pallet is similar to
-- Visual Studio Code

local commands = {
	{ name = "FormatDocument", command = "Neoformat", desc = "Format Document" },

	{ name = "CloseAllEditors", command = "BufferCloseAllButCurrent", desc = "Close All Editors" },

	{ name = "CreateNewFile", command = "BufferCloseAllButCurrent", desc = "Create: New File" },

	{ name = "ColorTheme", command = "Telescope colorscheme", desc = "Preferences: Color Theme" },

	{ name = "ReloadWindow", command = "windo e", desc = "Developer: Reload Window" },

	{ name = "TogglePrimarySideBarVisibility", command = "Neotree toggle", desc = "View: Toggle Primary Side Bar Visibility" },
};

for _, v in ipairs(commands) do
	vim.api.nvim_create_user_command(
		v.name,
		function() vim.cmd(v.command) end,
		{ desc = v.desc }
	)
end
