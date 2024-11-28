-- The initial start up time can be > 5 seconds
-- Because of this, we want to provide some user feedback that we are
-- Installing the dependencies
io.write "Starting NovaVim...";

require("modules.dependencies")

-- set up mason so that it can automatically install all the lsp servers and dependencies
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
    },
	ensure_installed = {
		"tree-sitter"
	},
})

require("modules.keymap")
require("modules.lsp.lsp_config")
require("modules.lsp.completions")
require("modules.ui")
require("modules.status_line")
require("modules.commands")
require("modules.explorer")
require("modules.settings")

require("nvim-autopairs").setup()

require("nvterm").setup()

require("gitsigns").setup {
	current_line_blame = true
}

require("project_nvim").setup()

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
	pickers = {
		colorscheme = {
			enable_preview = true,
		},
	},
}
require("telescope.builtin").buffers({
	sort_lastused = true,
	ignore_current_buffer = true,
	sort_mru = true
})

require("ibl").setup()

require("nvterm.terminal")
vim.opt.termguicolors = true

require("nvim-highlight-colors").setup {
	render = "virtual",
	virtual_symbol = "■",
	enable_named_colors = true,
	enable_tailwind = true,
}

-- these are my color overrides
-- If I don"t import this module last, tree sitter will overwrite the colors
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

require("nvim_comment").setup()
require("scrollbar").setup({
    handle = {
        text = "   ",
    },
    -- we double the marks here so that the scrollbar width is 2 characters
    -- wide instead of the default 1
    marks = {
        Search = { text = { "--", "==" } },
        Error = { text = { "--", "==" } },
        Warn = { text = { "--", "==" } },
        Info = { text = { "--", "==" } },
        Hint = { text = { "--", "==" } },
        Misc = { text = { "--", "==" } },
    }
})

require("virt-column").setup()
require("guess-indent").setup()
