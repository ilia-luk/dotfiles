local status_ok, marks = pcall(require, "marks")
if not status_ok then
	return
end

local which_status_ok, which_key = pcall(require, "which-key")
if not which_status_ok then
	return
end

marks.setup({
	-- whether to map keybinds or not. default true
	default_mappings = true,
	-- which builtin marks to show. default {}
	builtin_marks = { ".", "<", ">", "^" },
	-- whether movements cycle back to the beginning/end of buffer. default true
	cyclic = true,
	-- whether the shada file is updated after modifying uppercase marks. default false
	force_write_shada = false,
	-- how often (in ms) to redraw signs/recompute mark positions.
	-- higher values will have better performance but may cause visual lag,
	-- while lower values may cause performance penalties. default 150.
	refresh_interval = 250,
	-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
	-- marks, and bookmarks.
	-- can be either a table with all/none of the keys, or a single number, in which case
	-- the priority applies to all marks.
	-- default 10.
	sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
	-- disables mark tracking for specific filetypes. default {}
	excluded_filetypes = {},
	-- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
	-- sign/virttext. Bookmarks can be used to group together positions and quickly move
	-- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
	-- default virt_text is "".
	bookmark_0 = {
		sign = "⚑",
		virt_text = "hello world",
		-- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
		-- defaults to false.
		annotate = false,
	},
	mappings = {},
})

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
}

local mappings = {
	["m"] = {
		name = "Bookmarks",
		["1"] = { "<cmd> BookmarksList 1<cr>", "List 1" },
		["2"] = { "<cmd> BookmarksList 2<cr>", "List 2" },
		["3"] = { "<cmd> BookmarksList 3<cr>", "List 3" },
		["4"] = { "<cmd> BookmarksList 4<cr>", "List 4" },
		["5"] = { "<cmd> BookmarksList 5<cr>", "List 5" },
		["6"] = { "<cmd> BookmarksList 6<cr>", "List 6" },
		["7"] = { "<cmd> BookmarksList 7<cr>", "List 7" },
		["8"] = { "<cmd> BookmarksList 8<cr>", "List 8" },
		["9"] = { "<cmd> BookmarksList 9<cr>", "List 9" },
		["0"] = { "<cmd> BookmarksList 0<cr>", "List 0" },
		a = { "<cmd>BookmarksListAll<cr>", "List all" },
		c = { "<cmd>MarksListBuf<cr>", "List current" },
		t = { "<cmd>MarksToggleSigns<cr>", "Toggle" },
		["T"] = {
			name = "Groups",
			["0"] = { "<cmd>MarksToggleSigns 0<cr>", "Toggle 0" },
			["1"] = { "<cmd>MarksToggleSigns 1<cr>", "Toggle 1" },
			["2"] = { "<cmd>MarksToggleSigns 2<cr>", "Toggle 2" },
			["3"] = { "<cmd>MarksToggleSigns 3<cr>", "Toggle 3" },
		},
		h = { "<cmd>help marks-setup<cr>", "Help" },
	},
}

which_key.register(mappings, opts)
