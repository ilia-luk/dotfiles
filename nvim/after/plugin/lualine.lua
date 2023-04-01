local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local info_status_ok, package_info = pcall(require, "package-info")
if not info_status_ok then
	return
end

local navic_status_ok, navic = pcall(require, "nvim-navic")
if not navic_status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local function current_buffer_number()
	return "﬘ " .. vim.api.nvim_get_current_buf()
end

local function package_info_status()
	return package_info.get_status()
end

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

-- local function current_date()
--   return string.sub(os.date "%x", 1, 5)
-- end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local packages = {
	"packages",
	fmt = package_info_status,
	colored = false,
}

local context = {
	"context",
	fmt = navic.get_location,
	cond = navic.is_available,
}

local diff = {
	"diff",
	colored = false,
	source = diff_source,
	cond = hide_in_width,
}

local mode = {
	"mode",
	fmt = function(str)
		return "-- " .. str .. " --"
	end,
}

local filetype = {
	"filetype",
	icon_only = true,
	colored = false,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 0,
}

-- cool function for progress
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "⦚", right = " ⦚" },
		section_separators = { left = " ", right = " " },
		disabled_filetypes = { "alpha", "dashboard", "Outline" },
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { branch, diagnostics },
		lualine_b = { mode },
		lualine_c = {
			{ "filename", path = 1, symbols = { modified = "[]", readonly = " " } },
			context,
			{ "lsp_progress", display_components = { "lsp_client_name" } },
		},
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = {
			diff,
			-- spaces,
			"encoding",
			filetype,
			{
				require("lazy.status").updates,
				cond = require("lazy.status").has_updates,
				color = { fg = "#ff9e64" },
			},
		},
		lualine_y = {
			{ current_buffer_number, color = { fg = "#A9A9A9" } },
			location,
		},
		lualine_z = { progress, packages },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
