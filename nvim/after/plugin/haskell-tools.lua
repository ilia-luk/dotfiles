local haskell_tools_status_ok, ht = pcall(require, "haskell-tools")
if not haskell_tools_status_ok then
	return
end

local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
	return
end

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

ht.setup({
	tools = { -- haskell-tools options
		codeLens = {
			-- Whether to automatically display/refresh codeLenses
			-- (explicitly set to false to disable)
			autoRefresh = true,
		},
		hoogle = {
			-- 'auto': Choose a mode automatically, based on what is available.
			-- 'telescope-local': Force use of a local installation.
			-- 'telescope-web': The online version (depends on curl).
			-- 'browser': Open hoogle search in the default browser.
			mode = "telescope-local",
		},
		repl = {
			-- 'builtin': Use the simple builtin repl
			-- 'toggleterm': Use akinsho/toggleterm.nvim
			handler = "toggleterm",
			-- Can be overriden to either `true` or `false`. The default behaviour depends on the handler.
			auto_focus = true,
		},
	},
	-- hls = {
	-- 	on_attach = function(client, bufnr)
	-- 		local def_opts = vim.tbl_extend("keep", { silet = true, noremap = true }, { buffer = bufnr })
	-- 		-- haskell-language-server relies heavily on codeLenses,
	-- 		-- so auto-refresh (see advanced configuration) is enabled by default
	-- 		vim.keymap.set("n", "<leader>Hl", vim.lsp.codelens.run, def_opts)
	-- 		vim.keymap.set("n", "<leader>Hs", ht.hoogle.hoogle_signature, def_opts)
	-- 		-- default_on_attach(client, bufnr)  -- if defined, see nvim-lspconfig
	-- 	end,
	-- },
})

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["H"] = {
		name = "Haskell",
		s = { ht.hoogle.hoogle_signature, "Hoogle search" },
		l = { vim.lsp.codelens.run, "Codelens" },
		["r"] = {
			name = "Repl",
			t = { ht.repl.toggle, "Toggle" },
			q = { ht.repl.quit, "Quit" },
			-- c = { ht.repl.toggle(vim.api.nvim_buf_get_name(0)), "Current Buffer" },
		},
	},
}

telescope.load_extension("ht")

which_key.register(mappings, opts)
