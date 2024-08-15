local language_servers = { "tsserver", "astro", "angularls", "lua_ls", "bashls", "gopls", "templ", "htmx", "html", "cssls", "ruby_lsp", "rust_analyzer", "tailwindcss", "yamlls", "csharp_ls", "dockerls", "eslint" }
local tree_sitter_languages = { "c", "cpp", "make", "cmake", "angular", "ruby", "lua", "vim", "vimdoc", "query", "bash", "tsx", "c_sharp", "dockerfile", "gitignore", "go", "xml", "yaml", "json", "python", "r", "scss", "ruby", "rust", "html", "css", "typescript", "javascript", "astro" }

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

-- Set up lspconfig
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- LSP config
local lspconfig = require("lspconfig")
lspconfig.tsserver.setup { capabilities = capabilities }
lspconfig.astro.setup{ capabilities = capabilities }
lspconfig.angularls.setup{ capabilities = capabilities }
lspconfig.lua_ls.setup { capabilities = capabilities }
lspconfig.bashls.setup{ capabilities = capabilities }
lspconfig.gopls.setup{ capabilities = capabilities }
lspconfig.templ.setup{ capabilities = capabilities }
lspconfig.htmx.setup{ capabilities = capabilities }
lspconfig.html.setup{ capabilities = capabilities }
lspconfig.cssls.setup{ capabilities = capabilities }
lspconfig.ruby_lsp.setup{ capabilities = capabilities }
lspconfig.rust_analyzer.setup{ capabilities = capabilities }
lspconfig.tailwindcss.setup{ capabilities = capabilities }
lspconfig.yamlls.setup{ capabilities = capabilities }
lspconfig.csharp_ls.setup{ capabilities = capabilities }
lspconfig.dockerls.setup{ capabilities = capabilities }
lspconfig.eslint.setup{}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<F12>", vim.lsp.buf.definition, opts)

    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-K>", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, opts)
  end,
})
