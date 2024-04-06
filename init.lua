require "dependencies"
require "keymap"
require "languages"
require "completions"
require "ui"

require("nvim-autopairs").setup{}
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
    }
})

require("nvterm").setup()

require('gitsigns').setup()

require("project_nvim").setup()

require("nvim-tree").setup({
	filters = {
		git_ignored = false,
	}
})

require("lualine").setup {
	options = { theme = "codedark" }
}

local telescope = require("telescope")
telescope.setup {
	defaults = {
		layout_config = {
			prompt_position = "top",
		},
		file_ignore_patterns = { "node_modules", ".git" },
	},
	buffers = {
		sort_lastused = true,
		sort_mru = true,
	},
}
require('telescope.builtin').buffers({
	sort_lastused = true,
	ignore_current_buffer = true,
	sort_mru = true
})

require("ibl").setup()

require("nvterm.terminal")
