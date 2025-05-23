-- configure the lsp keymap
require("modules.lsp.lsp_keymap")
require("modules.lsp.goto_definition")

-- I define lsps and their tree sitter counter parts in a table so that I can
-- easily see what languages I have set up by default, and what languages
-- have syntax highlighting through tree sitter and not lsp (and the inverse)
local languages = {
	-- TODO: For some reason, these lsps fail to install through Mason
	-- The install script automatically installs these lsps, so I am not
	-- too concerned, but it is something that I should be aware of
	{ lsp = "ts_ls", tree_sitter = "typescript" },
	{ lsp = "eslint", tree_sitter = "javascript" },
	{ lsp = "angularls", tree_sitter = "angular" },
	{ lsp = false, tree_sitter = "typescript" },

	-- { lsp = false, tree_sitter = "javascript" },
	-- { lsp = false, tree_sitter = "angular" },

	{ lsp = "astro", tree_sitter = "astro" },
	{ lsp = "lua_ls", tree_sitter = "lua" },
	{ lsp = "bashls", tree_sitter = "bash" },
	{ lsp = "html", tree_sitter = "html" },
	{ lsp = "cssls", tree_sitter = "css" },
	{ lsp = "rust_analyzer", tree_sitter = "rust" },
	{ lsp = "yamlls", tree_sitter = "yaml" },
	{ lsp = "dockerls", tree_sitter = "dockerfile" },
	{ lsp = "pylsp", tree_sitter = "python" },
	{ lsp = "powershell_es", tree_sitter = "powershell" },

	-- clangd covers both c and cpp
	{ lsp = "clangd", tree_sitter = "c" },
	{ lsp = false, tree_sitter = "cpp" },

	{ lsp = "tailwindcss", tree_sitter = false },
	{ lsp = "templ", tree_sitter = false },
	{ lsp = "htmx", tree_sitter = false },

	{ lsp = false, tree_sitter = "tsx" },
	{ lsp = false, tree_sitter = "prolog" },
	{ lsp = false, tree_sitter = "java" },
	{ lsp = false, tree_sitter = "scss" },
	{ lsp = false, tree_sitter = "json" },
	{ lsp = false, tree_sitter = "xml" },
	{ lsp = false, tree_sitter = "gitignore" },
	{ lsp = false, tree_sitter = "vim" },
	{ lsp = false, tree_sitter = "vimdoc" },

	-- markdown support for trouble
	{ lsp = false, tree_sitter = "markdown" },
	{ lsp = false, tree_sitter = "markdown_inline" },

	-- for some reason, the C# and ruby lsps cannot be installed by
	-- the lsp auto-config
	-- TODO: figure out why and get ruby and C# working
	--{ lsp = "rubocop", tree_sitter = "ruby" },
	--{ lsp = "csharp_ls", tree_sitter = "c_sharp" },
	-- { lsp = false, tree_sitter = "latex" },
	-- { lsp = false, tree_sitter = "fsharp" },
	{ lsp = false, tree_sitter = "ruby" },
	{ lsp = false, tree_sitter = "c_sharp" },
	{ lsp = false, tree_sitter = "go" },
	{ lsp = false, tree_sitter = "cmake" },
	{ lsp = false, tree_sitter = "r" },
}

local tree_sitter_languages = {}
local language_servers = {}

for _, language in ipairs(languages) do
	local lsp = language.lsp
	local tree_sitter = language.tree_sitter

	if lsp ~= false then
		table.insert(language_servers, lsp)
	end

	if tree_sitter ~= false then
		table.insert(tree_sitter_languages, tree_sitter)
	end
end

-- mason-lspconfig will automatically install the language servers for you
require("mason-lspconfig").setup{
  ensure_installed = language_servers,
  automatic_installation = true,
}

require"nvim-treesitter.configs".setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = tree_sitter_languages,

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
--
-- Set up lspconfig
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

for _, language in ipairs(languages) do
	local lsp = language.lsp

	if lsp ~= false then
		lspconfig[lsp].setup{ capabilities = capabilities }
	end
end

vim.diagnostic.config({
	virtual_text = false,
	underline = true,
})
