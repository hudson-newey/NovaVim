-- The initial start up time can be > 5 seconds
-- Because of this, we want to provide some user feedback that we are
-- Installing the dependencies
io.write "Starting NovaVim...";

require("modules.dependencies")
require("modules.keymap")
require("modules.languages")
require("modules.completions")
require("modules.ui")
require("modules.explorer")

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
vim.opt.termguicolors = true

require("nvim-highlight-colors").setup {
	render = 'virtual',
	virtual_symbol = '■',
	enable_named_colors = true,
	enable_tailwind = true,
}

-- these are my color overrides
-- If I don't import this module last, tree sitter will overwrite the colors
require("modules.highlights")

require("neo-tree").setup {
	window = {
		width = 35,
	},
	icon = {
		folder_empty = "",
	},
	filesystem = {
		filtered_items = {
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_hidden = false,
		},
	},
	mappings = {
		["v"] = "open_vsplit",
		["^v"] = "open_vsplit",
	},
}

require("barbecue").setup()
require("barbecue.ui").toggle(true)
