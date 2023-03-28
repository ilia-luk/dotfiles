local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- AutoFommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Install your plugins here
return packer.startup(function(use)
	--	use { "moll/vim-bbye" }

	-- Cheat sheet
	use({ "folke/which-key.nvim" })

	--	Welcome screen
	use({ "goolord/alpha-nvim" })

	--	Project
	use({ "ahmedkhalf/project.nvim" })

	--  Loading time
	use({ "lewis6991/impatient.nvim" })

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("LukasPietzschmann/telescope-tabs")

	-- Colorschemes
	use("olimorris/onedarkpro.nvim")

	-- Treesitter
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-textobjects")

	-- Harpoon
	use("theprimeagen/harpoon")

	-- Undo
	use("mbbill/undotree")

	-- Git
	use({ "lewis6991/gitsigns.nvim" })
	use({ "f-person/git-blame.nvim" })
	use({ "ruifm/gitlinker.nvim" })

	-- LSP
	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "jayp0521/mason-null-ls.nvim" },
			{ "lvimuser/lsp-inlayhints.nvim" },
			{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

			-- Autocompletion CMP
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-emoji" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	-- Zen
	use("folke/zen-mode.nvim")

	-- Markers
	use("chentoast/marks.nvim")

	-- Persist multi clipboard
	use("AckslD/nvim-neoclip.lua")

	-- Database SQL for persisting plugin state
	use("kkharji/sqlite.lua")

	-- CoPilot
	use("github/copilot.vim")

	-- Context status line
	use("SmiteshP/nvim-navic")

	-- Context closing brackets
	use("haringsrob/nvim_context_vt")

	-- Indent
	use("lukas-reineke/indent-blankline.nvim")

	-- Icons
	use("nvim-tree/nvim-web-devicons")

	-- Comments
	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("folke/todo-comments.nvim")

	-- Brackets
	use("p00f/nvim-ts-rainbow")

	-- Autopair
	use("windwp/nvim-autopairs")

	--Tree
	use("kyazdani42/nvim-tree.lua")

	-- Line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	--  Bufferline
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

	-- Terminal
	use({ "akinsho/toggleterm.nvim" })

	-- Move through highlights
	use({ "jinh0/eyeliner.nvim" })
	use({ "ggandor/leap.nvim" })

	-- Pick lines
	use({ "nacro90/numb.nvim" })

	-- Scrolling
	use({ "opalmay/vim-smoothie" })
	use({ "petertriho/nvim-scrollbar" })

	-- Progress
	use({ "j-hui/fidget.nvim" })

	-- Auto rename tags
	use({ "windwp/nvim-ts-autotag" })

	-- Auto surround words
	use({ "kylechui/nvim-surround" })

	-- Colorizer
	use({ "NvChad/nvim-colorizer.lua" })

	-- Highlighter
	use({ "RRethy/vim-illuminate" })

	-- Troubleshoot
	use({ "folke/trouble.nvim" })

	-- Package.json
	use({
		"vuki656/package-info.nvim",
		requires = {
			"MunifTanjim/nui.nvim",
		},
	})

	-- Cycle buffer
	use({ "ghillb/cybu.nvim" })

	-- Multiple cursors
	use({ "mg979/vim-visual-multi" })

	-- Vim practice games
	use({ "theprimeagen/vim-be-good" })

	-- Diff tool
	use({ "sindrets/diffview.nvim" })

	-- Replace tool
	use({ "windwp/nvim-spectre" })

	-- Haskell tools
	use({ "mrcjkb/haskell-tools.nvim" })

	-- Chat GPT
	use({
		"jackMort/ChatGPT.nvim",
		requires = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	})

	-- Debugging
	use({ "mfussenegger/nvim-dap" })

	-- Debugger user interface
	use({ "rcarriga/nvim-dap-ui" })

	-- JS DAP Adapter
	use({ "mxsdev/nvim-dap-vscode-js" })

	-- Microsdt VSCode JS debugger
	use({
		"microsoft/vscode-js-debug",
		opt = true,
		run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	})

	-- Telescope DAP Plugin
	use("nvim-telescope/telescope-dap.nvim")

	-- Highlight DAP Plugin
	use("theHamsta/nvim-dap-virtual-text")

	-- Test runner
	use({
		"nvim-neotest/neotest",
		requires = {
			"haydenmeade/neotest-jest",
			"mrcjkb/neotest-haskell",
			"antoinemadec/FixCursorHold.nvim",
		},
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
