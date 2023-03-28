local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end

local dap_js_status_ok, dapjs = pcall(require, "dap-vscode-js")
if not dap_js_status_ok then
	return
end

local which_status_ok, which_key = pcall(require, "which-key")
if not which_status_ok then
	return
end

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
	return
end

local virtual_status_ok, virtual_text = pcall(require, "nvim-dap-virtual-text")
if not virtual_status_ok then
	return
end

-- UI setup:
dapui.setup({
	icons = { expanded = "", collapsed = "", circular = "" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	-- Use this to override mappings for specific elements
	element_mappings = {},
	expand_lines = true,
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.33 },
				{ id = "breakpoints", size = 0.17 },
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 0.25 },
			},
			size = 0.33,
			position = "right",
		},
		{
			elements = {
				{ id = "repl", size = 0.45 },
				{ id = "console", size = 0.55 },
			},
			size = 0.27,
			position = "bottom",
		},
	},
	controls = {
		enabled = true,
		-- Display controls in this element
		element = "repl",
		icons = {
			pause = "",
			play = "",
			step_into = "",
			step_over = "",
			step_out = "",
			step_back = "",
			run_last = "",
			terminate = "",
		},
	},
	floating = {
		max_height = 0.9,
		max_width = 0.5, -- Floats will be treated as percentage of your screen.
		border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil, -- Can be integer or nil.
		max_value_lines = 100, -- Can be integer or nil.
	},
})

vim.fn.sign_define("DapBreakpoint", {
	text = "",
	texthl = "DiagnosticSignError",
	linehl = "",
	numhl = "",
})
vim.fn.sign_define("DapBreakpointRejected", {
	text = "",
	texthl = "DiagnosticSignError",
	linehl = "",
	numhl = "",
})
vim.fn.sign_define("DapStopped", {
	text = "",
	texthl = "DiagnosticSignWarn",
	linehl = "Visual",
	numhl = "DiagnosticSignWarn",
})

dap.set_log_level("info")

-- Auto open
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
-- 	dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
-- 	dapui.close()
-- end

-- Adapters setup:
dapjs.setup({
	-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
	-- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
	-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
	-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
	-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
	-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

dap.adapters.chrome = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/debuggers/vscode-chrome-debug/out/src/chromeDebug.js" }, -- TODO adjust
}

dap.adapters.firefox = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/debuggers/vscode-firefox-debug/dist/adapter.bundle.js" },
}

dap.adapters.haskell = {
	type = "executable",
	command = "haskell-debug-adapter",
	args = { "--hackage-version=0.0.33.0" },
}

dap.configurations.haskell = {
	{
		type = "haskell",
		request = "launch",
		name = "Debug",
		program = "${file}",
		workspace = "${workspaceFolder}",
		startup = "${workspaceFolder}/test/Spec.hs",
		startupFunc = "",
		startupArgs = "",
		stopOnEntry = false,
		mainArgs = "",
		forceInspect = false,
		logFile = vim.fn.stdpath("data") .. "/haskell-dap.log",
		logLevel = "WARNING",
		ghciEnv = vim.empty_dict(),
		ghciPrompt = "λ: ",
		-- Adjust the prompt to the prompt you see when you invoke the stack ghci command below
		ghciInitialPrompt = "λ: ",
		ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
	},
}

for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
	dap.configurations[language] = {
		{
			name = "Launch file",
			type = "pwa-node",
			request = "launch",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			name = "Attach",
			type = "pwa-node",
			request = "attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
			protocol = "inspector",
		},
		{
			name = "Debug Nest Microservice",
			type = "pwa-node",
			request = "launch",
			runtimeExecutable = "npm",
			runtimeArgs = { "run", "start:debug" },
			localRoot = "/apps/${workspaceFolderBasename}",
			cwd = "${workspaceFolder}",
			port = 9229,
			protocol = "inspector",
		},
		-- [JEST] Jest now works with neotest plugin, leaving conf here for reference.
		-- {
		-- 	name = "Debug Nest Jest tests",
		-- 	type = "pwa-node",
		-- 	request = "launch",
		-- 	runtimeExecutable = "npm",
		-- 	runtimeArgs = { "run", "test:watch", "-- -i ${relativeFile}" },
		-- 	localRoot = "/apps/${workspaceFolderBasename}",
		-- 	cwd = "${workspaceFolder}",
		-- 	trace = true, -- include debugger info
		-- 	rootPath = "${workspaceFolder}/apps/${workspaceFolderBasename}",
		-- 	console = "integratedTerminal",
		-- 	internalConsoleOptions = "neverOpen",
		-- },
		{
			name = "Debug with Chrome",
			type = "pwa-chrome",
			request = "launch",
			url = "http://localhost:3000",
			webRoot = "${workspaceFolder}",
		},
		{
			name = "Debug with Firefox",
			type = "firefox",
			request = "launch",
			reAttach = true,
			url = "http://localhost:3000",
			webRoot = "${workspaceFolder}",
			firefoxExecutable = "/opt/homebrew/bin/firefox",
		},

		-- [CHROME] Currently working through dap-vscode-js adapter, leaving here for reference.
		-- {
		-- 	name = "Attach Chrome",
		-- 	type = "chrome",
		-- 	request = "attach",
		-- 	program = "${file}",
		-- 	cwd = vim.fn.getcwd(),
		-- 	sourceMaps = true,
		-- 	protocol = "inspector",
		-- 	port = 9222,
		-- 	webRoot = "${workspaceFolder}",
		-- },
	}
end

virtual_text.setup({
	enabled = true, -- enable this plugin (the default)
	enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
	highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
	highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
	show_stop_reason = true, -- show stop reason when stopped for exceptions
	commented = false, -- prefix virtual text with comment string
	only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
	all_references = false, -- show virtual text on all all references of the variable (not only definitions)
	--- A callback that determines how a variable is displayed or whether it should be omitted
	display_callback = function(variable)
		return variable.name .. " = " .. variable.value
	end,
	-- experimental features:
	virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
	all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
	virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
	virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
	-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
})

telescope.load_extension("dap")

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
}

local mappings = {
	d = {
		name = "Debug",
		t = { "<cmd>lua require'dap-vscode-js'.debug_test()<cr>", "Run" },
		b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
		B = {
			"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
			"Breakpoint condition",
		},
		p = {
			"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
			"Log point message",
		},
		c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
		o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
		O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
		r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
		l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
		u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
		x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
		d = { "<cmd> lua require'telescope'.extensions.dap.commands()<cr>", "Commands" },
		C = { "<cmd> lua require'telescope'.extensions.dap.configurations()<cr>", "Configurations" },
		a = { "<cmd> lua require'telescope'.extensions.dap.list_breakpoints()<cr>", "List breakpoints" },
		v = { "<cmd> lua require'telescope'.extensions.dap.variables()<cr>", "Variables" },
		f = { "<cmd> lua require'telescope'.extensions.dap.frames()<cr>", "Frames" },
	},
}

which_key.register(mappings, opts)
