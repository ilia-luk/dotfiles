local harpoon_mark_status_ok, mark = pcall(require, "harpoon.mark")
if not harpoon_mark_status_ok then
	return
end

local harpoon_ui_status_ok, ui = pcall(require, "harpoon.ui")
if not harpoon_ui_status_ok then
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
	o = {
		name = "Harpoon",
		[";"] = {
			function()
				ui.toggle_quick_menu()
			end,
			"Toggle quick menu",
		},
		a = {
			function()
				mark.add_file()
			end,
			"Add file",
		},
		[","] = {
			function()
				ui.nav_prev()
			end,
			"Harpoon prev",
		},
		["."] = {
			function()
				ui.nav_next()
			end,
			"Harpoon next",
		},
		s = { "<cmd>Telescope harpoon marks<cr>", "Search files" },
		q = { function() end, "Quick access" },
		q1 = {
			function()
				ui.nav_file(1)
			end,
			"File 1",
		},
		q2 = {
			function()
				ui.nav_file(2)
			end,
			"File 2",
		},
		q3 = {
			function()
				ui.nav_file(3)
			end,
			"File 3",
		},
		q4 = {
			function()
				ui.nav_file(4)
			end,
			"File 4",
		},
		q5 = {
			function()
				ui.nav_file(5)
			end,
			"File 4",
		},
		q6 = {
			function()
				ui.nav_file(6)
			end,
			"File 6",
		},
		q7 = {
			function()
				ui.nav_file(7)
			end,
			"File 7",
		},
		q8 = {
			function()
				ui.nav_file(8)
			end,
			"File 8",
		},
		q9 = {
			function()
				ui.nav_file(9)
			end,
			"File 9",
		},
	},
}

which_key.register(mappings, opts)
