local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
	return
end

local which_status_ok, which_key = pcall(require, "which-key")
if not which_status_ok then
	return
end

neotest.setup({
	adapters = {
		require("neotest-jest")({
			jestCommand = "npm test --",
			jestConfigFile = "jest.config.ts",
			env = { CI = true },
			cwd = function()
				return vim.fn.getcwd()
			end,
		}),
		require("neotest-haskell")({
			-- Default: Use stack if possible and then try cabal
			build_tools = { "stack", "cabal" },
		}),
	},
})

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
}

local mappings = {
	["x"] = {
		name = "Tests",
		r = { "<cmd>lua require('neotest').run.run()<cr>", "Run" },
		w = { "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch'})<cr>", "Run watch" },
		e = { "<cmd>lua require('neotest').run.run(vim.fn.expand(' % '))<cr>", "Run expanded" },
		d = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Run DAP Debug" },
		s = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
		a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach" },
		o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" },
		t = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary toggle" },
		p = { "<cmd>lua require('neotest').output_panel.toggle()<cr>", "Output panel toggle" },
		h = { "<cmd>:h neotest<cr>", "Help" },
	},
}

which_key.register(mappings, opts)
