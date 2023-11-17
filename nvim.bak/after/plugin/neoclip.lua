local status_ok, neoclip = pcall(require, "neoclip")
if not status_ok then
	return
end

local which_status_ok, which_key = pcall(require, "which-key")
if not which_status_ok then
	return
end

neoclip.setup({
	history = 1000,
	enable_persistent_history = true,
	length_limit = 1048576,
	continuous_sync = false,
	db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
	filter = nil,
	preview = true,
	prompt = nil,
	default_register = '"',
	default_register_macros = "q",
	enable_macro_history = true,
	content_spec_column = false,
	on_select = {
		move_to_front = false,
		close_telescope = true,
	},
	on_paste = {
		set_reg = false,
		move_to_front = false,
		close_telescope = true,
	},
	on_replay = {
		set_reg = false,
		move_to_front = false,
		close_telescope = true,
	},
	on_custom_action = {
		close_telescope = true,
	},
	keys = {
		telescope = {
			i = {
				select = "<cr>",
				paste = "<c-p>",
				paste_behind = "<c-k>",
				replay = "<c-q>", -- replay a macro
				delete = "<c-d>", -- delete an entry
				edit = "<c-e>", -- edit an entry
				custom = {},
			},
			n = {
				select = "<cr>",
				paste = "p",
				--- It is possible to map to more than one key.
				-- paste = { 'p', '<c-p>' },
				paste_behind = "P",
				replay = "q",
				delete = "d",
				edit = "e",
				custom = {},
			},
		},
		fzf = {
			select = "default",
			paste = "ctrl-p",
			paste_behind = "ctrl-k",
			custom = {},
		},
	},
})

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
}

local mappings = {
	["y"] = {
		name = "Clipboard",
		o = { "<cmd>lua require('telescope').extensions.neoclip.default()<cr>", "Open scope" },
		m = { "<cmd>lua require('telescope').extensions.macroscope.default()<cr>", "Open macroscope" },
		s = { neoclip.start, "Start" },
		S = { neoclip.stop, "Stop" },
		t = { neoclip.toggle, "Toggle" },
		p = { neoclip.db_pull, "Pull db" },
		P = { neoclip.db_push, "Push db" },
		c = { neoclip.clear_history, "Clear db" },
	},
}

which_key.register(mappings, opts)
