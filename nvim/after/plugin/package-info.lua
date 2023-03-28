local status_ok, package_info = pcall(require, "package-info")
if not status_ok then
	return
end

local which_status_ok, which_key = pcall(require, "which-key")
if not which_status_ok then
	return
end

package_info.setup({
	colors = {
		up_to_date = "#3C4048", -- Text color for up to date dependency virtual text
		outdated = "#d19a66", -- Text color for outdated dependency virtual text- Text color for outdated dependency virtual text
	},
	icons = {
		enable = true, -- Whether to display icons
		style = {
			up_to_date = "|  ", -- Icon for up to date dependencies
			outdated = "|  ", -- Icon for outdated dependencies
		},
	},
	autostart = true, -- Whether to autostart when `package.json` is opened
	hide_up_to_date = false, -- It hides up to date versions when displaying virtual text
	hide_unstable_versions = false, -- It hides unstable versions from version list e.g next-11.1.3-canary3
	-- Can be `npm`, `yarn`, or `pnpm`. Used for `delete`, `install` etc...
	-- The plugin will try to auto-detect the package manager based on
	-- `yarn.lock` or `package-lock.json`. If none are found it will use the
	-- provided one, if nothing is provided it will use `yarn`
	package_manager = "yarn",
})

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
}

local mappings = {
	["n"] = {
		name = "PackageInfo",
		s = { package_info.show, "Show" },
		h = { package_info.hide, "Hide" },
		t = { package_info.toggle, "Toggle" },
		u = { package_info.update, "Update" },
		d = { package_info.delete, "Delete" },
		i = { package_info.install, "Install" },
		c = { package_info.change_version, "Change version" },
	},
}

which_key.register(mappings, opts)
