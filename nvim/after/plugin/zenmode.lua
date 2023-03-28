local zen_mode_status_ok, zen_mode = pcall(require, "zen-mode")
if not zen_mode_status_ok then
	return
end

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

zen_mode.setup({
	window = {
		width = 90,
		options = {
			number = true,
			relativenumber = true,
		},
	},
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
	["Z"] = {
		function()
			zen_mode.toggle()
			vim.wo.wrap = false
			ColorMyPencils()
		end,
		"Zen mode",
	},
}

which_key.register(mappings, opts)
