local telescope_builtin_status_ok, builtin = pcall(require, "telescope.builtin")
if not telescope_builtin_status_ok then
	return
end

local tabs_status_ok, tabs = pcall(require, "telescope-tabs")
if not tabs_status_ok then
	return
end

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["S"] = {
		function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end,
		"Quick search",
	},
}

tabs.setup()
which_key.register(mappings, opts)
