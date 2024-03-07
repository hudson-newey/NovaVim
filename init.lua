local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
	"nvim-tree/nvim-tree.lua",
	"nvim-tree/nvim-web-devicons",
	"wfxr/minimap.vim",
	"sbdchd/neoformat",
	"github/copilot.vim",
	{'romgrk/barbar.nvim', opts = {}, init = function() vim.g.barbar_auto_setup = false end },
	{
	    'windwp/nvim-autopairs',
	    event = "InsertEnter",
	    opts = {}
	}
})

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

require("nvim-tree").setup()

require("lualine").setup {
	options = { theme = "codedark" }
}

require("ibl").setup()

local terminal = require("nvterm.terminal")

vim.api.nvim_set_keymap("n", "<C-P>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-O>", ":Telescope commands<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<CS-P>", ":Telescope commands<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-B>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<CS-E>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<CS-F>", ":lua require'telescope.builtin'.live_grep{}<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<CS-X>", ":Mason<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-S>", ":w<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-TAB>", ":BufferNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<CS-TAB>", ":BufferPrevious<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-W>", ":BufferClose<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-]>", ":BufferNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<CS-]>", ":BufferPrevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Q>", ":BufferClose<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", ":lua require('nvterm.terminal').toggle 'horizontal'<CR>", { noremap = true, silent = true })

-- make it so that when I press escape the grep results go away
vim.api.nvim_set_keymap("n", "<esc>", ":noh<CR>", { noremap = true, silent = true })

-- colorschemes I like
-- vim.cmd "colorscheme material-darker"
-- vim.cmd "colorscheme slate"
vim.cmd "colorscheme vscode"

-- set rulers
vim.cmd "let &colorcolumn='80,120'"

-- enable line numbers
vim.cmd "set nu"

-- enable minimap
vim.cmd "let g:minimap_width = 15"

--[=====[
vim.cmd[[
  augroup CustomCommands
    autocmd!
    autocmd BufReadPost * lua vim.cmd "Minimap"
  augroup END
  ]]
--]=====]

require"nvim-treesitter.configs".setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "bash", "cpp", "c_sharp", "dockerfile", "gitignore", "go", "html", "json", "latex", "nix", "python", "r", "scss", "ruby", "rust", "vue", "zig", "typescript", "javascript", "astro" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- Set up nvim-cmp.
local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP config
local lspconfig = require('lspconfig')
lspconfig.tsserver.setup { capabilities = capabilities }
lspconfig.astro.setup{ capabilities = capabilities }
lspconfig.angularls.setup{ capabilities = capabilities }
-- lspconfig.lua_ls.setup { capabilities = capabilities }
lspconfig.bashls.setup{ capabilities = capabilities }
lspconfig.golangci_lint_ls.setup{ capabilities = capabilities }
lspconfig.html.setup{ capabilities = capabilities }
lspconfig.cssls.setup{ capabilities = capabilities }
lspconfig.ruby_ls.setup{ capabilities = capabilities }
lspconfig.rust_analyzer.setup{ capabilities = capabilities }
lspconfig.tailwindcss.setup{ capabilities = capabilities }
lspconfig.yamlls.setup{ capabilities = capabilities }
lspconfig.csharp_ls.setup{ capabilities = capabilities }
lspconfig.dockerls.setup{ capabilities = capabilities }
lspconfig.eslint.setup{}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<F12>', vim.lsp.buf.definition, opts)

    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-K>', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<C-.>', vim.lsp.buf.code_action, opts)
  end,
})
