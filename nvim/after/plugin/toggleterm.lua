local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<C-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	-- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
	-- vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	hidden = true,
	direction = "tab",
	on_open = function(_)
		vim.cmd("startinsert!")
		vim.cmd("set laststatus=0")
	end,
	on_close = function(_)
		vim.cmd("set laststatus=3")
	end,
	count = 99,
})

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

local node = Terminal:new({ cmd = "node", hidden = true })

function _NODE_TOGGLE()
	node:toggle()
end

local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

function _NCDU_TOGGLE()
	ncdu:toggle()
end

local htop = Terminal:new({ cmd = "htop", hidden = true })

function _HTOP_TOGGLE()
	htop:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true })

function _PYTHON_TOGGLE()
	python:toggle()
end

local yarn_test = Terminal:new({ cmd = "yarn test", hidden = true })

function _YARN_TEST()
	yarn_test:toggle()
end

local yarn_test_watch = Terminal:new({ cmd = "yarn test:watch", direction = "vertical" })

function _YARN_TEST_WATCH()
	yarn_test_watch:toggle()
end

local float_term = Terminal:new({
	direction = "float",
	count = 1,
})

function _FLOAT_TERM()
	float_term:toggle()
end

local vertical_term = Terminal:new({
	direction = "vertical",
	count = 2,
})

function _VERTICAL_TERM()
	vertical_term:toggle(60)
end

local horizontal_term = Terminal:new({
	direction = "horizontal",
	count = 3,
})

function _HORIZONTAL_TERM()
	horizontal_term:toggle(10)
end
