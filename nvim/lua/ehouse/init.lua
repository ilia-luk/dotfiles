require("ehouse.keymaps")
require("ehouse.options")
require("ehouse.plugins")

local augroup = vim.api.nvim_create_augroup
local TheEhoseGroup = augroup("TheEhose", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = TheEhoseGroup,
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

require("nvim-web-devicons").setup({
	override = {
		zsh = { icon = "", color = "#428850", name = "Zsh" },
		lua = { icon = "", color = "#4E99DF", name = "Lua" },
		md = { icon = "", color = "#6BD02B", name = "Md" },
		[".gitignore"] = { icon = "", color = "#F14E32", name = "GitIgnore" },
	},
	default = true,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- nvim-tree: disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
