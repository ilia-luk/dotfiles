local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local builtins = null_ls.builtins
local code_actions = builtins.code_actions
local completion = builtins.completion
local diagnostics = builtins.diagnostics
local formatting = builtins.formatting

null_ls.setup({
	sources = {
		-- code_actions.cspell,
		code_actions.shellcheck,
		-- null_ls.builtins.code_actions.eslint_d,
		code_actions.gitsigns,
		completion.luasnip,
		completion.spell,
		-- diagnostics.cspell,
		diagnostics.actionlint,
		diagnostics.cfn_lint,
		-- diagnostics.eslint_d,
		-- diagnostics.eslint.with({}),
		diagnostics.jshint,
		diagnostics.markdownlint,
		-- null_ls.builtins.diagnostics.misspell,
		diagnostics.stylelint,
		diagnostics.tsc,
		formatting.cabal_fmt,
		-- formatting.codespell,
		-- null_ls.builtins.formatting.eslint_d,
		-- null_ls.builtins.formatting.eslint.with({}),
		-- formatting.markdownlint,
		-- null_ls.builtins.formatting.prettier_eslint,
		-- formatting.rome,
		-- formatting.stylelint,
		formatting.stylish_haskell,
		formatting.stylua,
		formatting.prettierd.with({
			env = {
				PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/after/linter-config/.prettierrc.json"),
			},
		}),
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
					-- vim.lsp.buf.format()
				end,
			})
		end
	end,
})
