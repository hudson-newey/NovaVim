function dir_exists(path)
  if (lfs.attributes(path, "mode") == "directory") then
    return true
  end
  return false
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local telescopePath = lazypath .. "/telescope.nvim"

local hasLazyInstalled = (vim.uv or vim.loop).fs_stat(lazypath)
local hasTelescopeInstalled = (vim.uv or vim.loop).fs_stat(telescopePath)

-- sometimes lazy can be stuck in a partially installed state
-- in this case, Lazy will be installed under ~/.local/share/nvim, but it won't have any extensions
-- Therefore, we check for an expected depdendency. If we do not find it, we reinstall Lazy
-- In an attempt to self-resolve issues
if not hasLazyInstalled or not hasTelescopeInstalled then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"williamboman/mason.nvim",
	{
		"nvim-telescope/telescope.nvim", branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{
	    "nvim-lualine/lualine.nvim",
	    dependencies = { "nvim-tree/nvim-web-devicons" }
	},
	{
		-- for breadcrumbs at the top of the window
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	"NvChad/nvterm",
	"marko-cerovac/material.nvim",
	"nvim-treesitter/nvim-treesitter",
	"Mofiqul/vscode.nvim",
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	'hrsh7th/vim-vsnip',
	'hrsh7th/vim-vsnip-integ',
	"lewis6991/gitsigns.nvim",
	{
	    "nvim-neo-tree/neo-tree.nvim",
	    branch = "v3.x",
	    dependencies = {
	      "nvim-lua/plenary.nvim",
	      "nvim-tree/nvim-web-devicons",
	      "MunifTanjim/nui.nvim",
	      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	    }
	},
	{
	    "wfxr/minimap.vim",
	    build = "cargo install --locked code-minimap",
	    lazy = false,
	    cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
	    init = function()
		vim.cmd("let g:minimap_width = 14")
		-- disable auto start because it's buggy when opening a directory
		vim.cmd("let g:minimap_auto_start = 0")
		vim.cmd("let g:minimap_auto_start_win_enter = 1")
	    end,
	},
	"sbdchd/neoformat",
	"github/copilot.vim",
	"ahmedkhalf/project.nvim", 
	"mg979/vim-visual-multi", 
	"brenoprata10/nvim-highlight-colors",
	{'romgrk/barbar.nvim', opts = {}, init = function() vim.g.barbar_auto_setup = false end },
	{
	    'windwp/nvim-autopairs',
	    event = "InsertEnter",
	    opts = {}
	}
})
