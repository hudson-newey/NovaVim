-- The initial start up time can be > 5 seconds
-- Because of this, we want to provide some user feedback that we are
-- Installing the dependencies
io.write "Starting NovaVim...";

require("modules.warnings")

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
require("git-conflict").setup()

require("project_nvim").setup()

local telescope = require("telescope")
telescope.setup {
	defaults = {
		layout_strategy = "horizontal",
		layout_config = {
			prompt_position = "top",
			horizontal = {
				preview_width = 0.35,
			},
			-- width = 0.9,
		},
		file_ignore_patterns = {
			"node_modules",
			".git",
			"target",
		},
		mappings = {
			i = {
				["<C-CR>"] = require('telescope.actions').select_vertical,

				-- pressing <Esc> closes Telescope instead of going into "normal" mode
				["<Esc>"] = require('telescope.actions').close,
			},
			n = {
				["<C-CR>"] = require('telescope.actions').select_vertical,
			},
		},
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

-- TODO: I don't know why I originally included this telescope plugin/builtin
-- The buffers builtin lets you search through the open buffers in telescope
-- however, I never made a keymap for anything in this module
--require("telescope.builtin").buffers({
--	sort_lastused = true,
--	ignore_current_buffer = true,
--	sort_mru = true
--})

local indentation_guide_char = "┊"
require("ibl").setup({
	indent = {
		-- The default vertical line character is quite large and makes
		-- the code base look noisy.
		-- To make the indentation guides less noisy, I have used the
		-- dotted line box drawing character.
		-- While this is unconventional for editors, I have chosen this
		-- character to maintain the same level of noise as other
		-- editors.
		--
		-- We have to set both char and tab_char so that workspaces
		-- that use spaces and tab characters have the same look.
		char = indentation_guide_char,
		tab_char = indentation_guide_char
	}
})

require("startup").setup({
	theme = "evil"
})

require("nvim-highlight-colors").setup {
	render = "virtual",
	virtual_symbol = "■",
	enable_named_colors = true,
	enable_tailwind = true,
}

-- these are my color overrides
-- If I don"t import this module last, tree sitter will overwrite the colors
require("modules.highlights")

local done_first_defocus = false
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
	event_handlers = {
		{
			event = "neo_tree_buffer_enter",
			handler = function()
				if not done_first_defocus then
					vim.api.nvim_input("<C-w>l")
					done_first_defocus = true
				end
			end,
		},
	},
}

require("barbecue").setup()
require("barbecue.ui").toggle(true)

require("nvim_comment").setup()
require("scrollbar").setup({
	handle = {
		text = "  ",
	},
	-- we double the marks here so that the scrollbar width is 2 characters
	-- wide instead of the default 1
	marks = {
		Cursor = { text = " •" },
		Search = { text = { "--", "==" } },
		Error = { text = { "--", "==" } },
		Warn = { text = { "--", "==" } },
		Info = { text = { "--", "==" } },
		Hint = { text = { "--", "==" } },
		Misc = { text = { "--", "==" } },
	}
})

-- TODO: Re-enable rainbow brackets. See dependencies.lua for more information
-- require("rainbow-delimiters.setup").setup()

require("virt-column").setup()
require("guess-indent").setup()


-- for some reason, neovim will not resize buffers when the window
-- resizes. This plugin fixes this weird nvim decision
-- TODO: This also effects the explorer, when it should not
require("bufresize").setup()

-- We initialize the llms module last because I suspect that llms are an external
-- dependency that makes it more flaky.
-- Therefore, if the llms fail to init, we are left with a mostly functional editor.
require("modules.ai.setup").setup()
