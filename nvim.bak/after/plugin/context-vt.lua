local status_ok, context = pcall(require, "nvim_context_vt")
if not status_ok then
	return
end

local which_status_ok, which_key = pcall(require, "which-key")
if not which_status_ok then
	return
end

context.setup({
	-- Enable by default. You can disable and use :NvimContextVtToggle to maually enable.
	-- Default: true
	enabled = true,

	-- Override default virtual text prefix
	-- Default: '-->'
	prefix = "",

	-- Override the internal highlight group name
	-- Default: 'ContextVt'
	highlight = "ContextVt",

	-- Disable virtual text for given filetypes
	-- Default: { 'markdown' }
	disable_ft = { "markdown" },

	-- Disable display of virtual text below blocks for indentation based languages like Python
	-- Default: false
	disable_virtual_lines = false,

	-- Same as above but only for spesific filetypes
	-- Default: {}
	disable_virtual_lines_ft = { "yaml" },

	-- How many lines required after starting position to show virtual text
	-- Default: 1 (equals two lines total)
	min_rows = 1,

	-- Same as above but only for spesific filetypes
	-- Default: {}
	min_rows_ft = {},
})

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
}

local mappings = {
	C = { "<cmd>NvimContextVtToggle<cr>", "Context toggle" },
}

which_key.register(mappings, opts)
