local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

local plugins = {
	-- Cheat sheet
	"folke/which-key.nvim",
	--	Welcome screen
	"goolord/alpha-nvim",
	--	Project
	"ahmedkhalf/project.nvim",
	--  Loading time
	"lewis6991/impatient.nvim",
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.0",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	"LukasPietzschmann/telescope-tabs",
	-- Colorschemes
	"olimorris/onedarkpro.nvim",
	-- Treesitter
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-textobjects",
	-- Harpoon
	"theprimeagen/harpoon",
	-- Undo
	"mbbill/undotree",
	-- Git
	"lewis6991/gitsigns.nvim",
	"f-person/git-blame.nvim",
	"ruifm/gitlinker.nvim",
	-- LSP
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			-- LSP Support
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			"jayp0521/mason-null-ls.nvim",
			"lvimuser/lsp-inlayhints.nvim",
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
			-- Autocompletion CMP
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-emoji",
			-- Snippets
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
	},
	-- LSP Kind
	"onsails/lspkind-nvim",
	-- Zen
	"folke/zen-mode.nvim",
	-- Markers
	"chentoast/marks.nvim",
	-- Persist multi clipboard
	"AckslD/nvim-neoclip.lua",
	-- Database SQL for persisting plugin state
	"kkharji/sqlite.lua",
	-- Copilot
	"zbirenbaum/copilot.lua",
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "copilot.lua" },
	},
	-- Context status line
	"SmiteshP/nvim-navic",
	-- Context closing brackets
	"haringsrob/nvim_context_vt",
	-- Indent
	"lukas-reineke/indent-blankline.nvim",
	-- Icons
	"nvim-tree/nvim-web-devicons",
	-- Comments
	"numToStr/Comment.nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"folke/todo-comments.nvim",
	-- Brackets
	"p00f/nvim-ts-rainbow",
	-- Autopair
	"windwp/nvim-autopairs",
	--Tree
	"kyazdani42/nvim-tree.lua",
	-- Line
	"nvim-lualine/lualine.nvim",
	--  Bufferline
	{
		"akinsho/bufferline.nvim",
		version = "v3.*",
	},
	-- Terminal
	"akinsho/toggleterm.nvim",
	-- Move through highlights
	"jinh0/eyeliner.nvim",
	"ggandor/leap.nvim",
	-- Pick lines
	"nacro90/numb.nvim",
	-- Scrolling
	"opalmay/vim-smoothie",
	"petertriho/nvim-scrollbar",
	-- Progress
	"j-hui/fidget.nvim",
	-- Auto rename tags
	"windwp/nvim-ts-autotag",
	-- Auto surround words
	"kylechui/nvim-surround",
	-- Colorizer
	"NvChad/nvim-colorizer.lua",
	-- Highlighter
	"RRethy/vim-illuminate",
	-- Troubleshoot
	"folke/trouble.nvim",
	-- Package.json
	{
		"vuki656/package-info.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	-- Cycle buffer
	"ghillb/cybu.nvim",
	-- Multiple cursors
	"mg979/vim-visual-multi",
	-- Vim practice games
	"theprimeagen/vim-be-good",
	-- Diff tool
	"sindrets/diffview.nvim",
	-- Replace tool
	"windwp/nvim-spectre",
	-- Haskell tools
	"mrcjkb/haskell-tools.nvim",
	-- Chat GPT
	{
		"jackMort/ChatGPT.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	-- Debugging
	"mfussenegger/nvim-dap",
	-- Debugger user interface
	"rcarriga/nvim-dap-ui",
	-- JS DAP Adapter
	"mxsdev/nvim-dap-vscode-js",
	-- Microsdt VSCode JS debugger
	{
		"microsoft/vscode-js-debug",
		lazy = true,
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	},
	-- Telescope DAP Plugin
	"nvim-telescope/telescope-dap.nvim",
	-- Highlight DAP Plugin
	"theHamsta/nvim-dap-virtual-text",
	-- Test runner
	{
		"nvim-neotest/neotest",
		dependencies = {
			"haydenmeade/neotest-jest",
			"mrcjkb/neotest-haskell",
			"antoinemadec/FixCursorHold.nvim",
		},
	},
}

local opts = {
	root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
	defaults = {
		lazy = false, -- should plugins be lazy-loaded?
		version = nil,
		-- default `cond` you can use to globally disable a lot of plugins
		-- when running inside vscode for example
		cond = nil,
		-- version = "*", -- enable this to try installing the latest stable versions of plugins
	},
	-- leave nil when passing the spec as the first argument to setup()
	spec = nil,
	lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
	concurrency = nil, ---@type number limit the maximum amount of concurrent tasks
	git = {
		-- defaults for the `Lazy log` command
		-- log = { "-10" }, -- show the last 10 commits
		log = { "--since=3 days ago" }, -- show commits from the last 3 days
		timeout = 120, -- kill processes that take more than 2 minutes
		url_format = "https://github.com/%s.git",
		-- lazy.nvim requires git >=2.19.0. If you really want to use lazy with an older version,
		-- then set the below to false. This should work, but is NOT supported and will
		-- increase downloads a lot.
		filter = true,
	},
	dev = {
		-- directory where you store your local plugin projects
		path = "~/projects",
		---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
		patterns = {}, -- For example {"folke"}
		fallback = false, -- Fallback to git when local plugin doesn't exist
	},
	install = {
		-- install missing plugins on startup. This doesn't increase startup time.
		missing = true,
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = { "habamax" },
	},
	ui = {
		-- a number <1 is a percentage., >1 is a fixed size
		size = { width = 0.8, height = 0.8 },
		wrap = true, -- wrap the lines in the ui
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = "none",
		icons = {
			cmd = " ",
			config = "",
			event = "",
			ft = " ",
			init = " ",
			import = " ",
			keys = " ",
			lazy = "󰒲 ",
			loaded = "●",
			not_loaded = "○",
			plugin = " ",
			runtime = " ",
			source = " ",
			start = "",
			task = "✔ ",
			list = {
				"●",
				"➜",
				"★",
				"‒",
			},
		},
		-- leave nil, to automatically select a browser depending on your OS.
		-- If you want to use a specific browser, you can define it here
		browser = nil, ---@type string?
		throttle = 20, -- how frequently should the ui process render events
		custom_keys = {
			-- you can define custom key maps here.
			-- To disable one of the defaults, set it to false

			-- open lazygit log
			["<localleader>l"] = function(plugin)
				require("lazy.util").float_term({ "lazygit", "log" }, {
					cwd = plugin.dir,
				})
			end,

			-- open a terminal for the plugin dir
			["<localleader>t"] = function(plugin)
				require("lazy.util").float_term(nil, {
					cwd = plugin.dir,
				})
			end,
		},
	},
	diff = {
		-- diff command <d> can be one of:
		-- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
		--   so you can have a different command for diff <d>
		-- * git: will run git diff and open a buffer with filetype git
		-- * terminal_git: will open a pseudo terminal with git diff
		-- * diffview.nvim: will open Diffview to show the diff
		cmd = "git",
	},
	checker = {
		-- automatically check for plugin updates
		enabled = false,
		concurrency = nil, ---@type number? set to 1 to check for updates very slowly
		notify = true, -- get a notification when new updates are found
		frequency = 3600, -- check for updates every hour
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = true,
		notify = true, -- get a notification when changes are found
	},
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true, -- reset the package path to improve startup time
		rtp = {
			reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
			---@type string[]
			paths = {}, -- add any custom paths here that you want to includes in the rtp
			---@type string[] list any plugins you want to disable here
			disabled_plugins = {
				-- "gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				-- "tarPlugin",
				-- "tohtml",
				-- "tutor",
				-- "zipPlugin",
			},
		},
	},
	-- lazy can generate helptags from the headings in markdown readme files,
	-- so :help works even for plugins that don't have vim docs.
	-- when the readme opens with :help it will be correctly displayed as markdown
	readme = {
		enabled = true,
		root = vim.fn.stdpath("state") .. "/lazy/readme",
		files = { "README.md", "lua/**/README.md" },
		-- only generate markdown helptags for plugins that dont have docs
		skip_if_doc_exists = true,
	},
	state = vim.fn.stdpath("state") .. "/lazy/state.json", -- state info for checker and other things
}

lazy.setup(plugins, opts)
