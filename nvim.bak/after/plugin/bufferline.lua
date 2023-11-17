local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

bufferline.setup({
	options = {
		offsets = {
			{
				filetype = "NvimTree",
				highlight = "Directory",
				text = function()
					local cwd = string.sub(vim.fn.getcwd(), 12)
					return "~" .. cwd
				end,
				text_align = "left",
				padding = 0,
			},
		},
		max_name_length = 30,
		max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
		tab_size = 28,
		separator_style = "thin",
		enforce_regular_tabs = true,
		always_show_bufferline = true,
		highlights = {
			fill = {
				fg = { attribute = "fg", highlight = "#ff0000" },
				bg = { attribute = "bg", highlight = "TabLine" },
			},
			background = {
				fg = { attribute = "fg", highlight = "TabLine" },
				bg = { attribute = "bg", highlight = "TabLine" },
			},

			-- buffer_selected = {
			--   fg = {attribute='fg',highlight='#ff0000'},
			--   bg = {attribute='bg',highlight='#0000ff'},
			--   gui = 'none'
			--   },
			buffer_visible = {
				fg = { attribute = "fg", highlight = "TabLine" },
				bg = { attribute = "bg", highlight = "TabLine" },
			},

			close_button = {
				fg = { attribute = "fg", highlight = "TabLine" },
				bg = { attribute = "bg", highlight = "TabLine" },
			},
			close_button_visible = {
				fg = { attribute = "fg", highlight = "TabLine" },
				bg = { attribute = "bg", highlight = "TabLine" },
			},
			-- close_button_selected = {
			--   fg = {attribute='fg',highlight='TabLineSel'},
			--   bg ={attribute='bg',highlight='TabLineSel'}
			--   },

			tab_selected = {
				fg = { attribute = "fg", highlight = "Normal" },
				bg = { attribute = "bg", highlight = "Normal" },
			},
			tab = {
				fg = { attribute = "fg", highlight = "TabLine" },
				bg = { attribute = "bg", highlight = "TabLine" },
			},
			tab_close = {
				-- fg = {attribute='fg',highlight='LspDiagnosticsDefaultError'},
				fg = { attribute = "fg", highlight = "TabLineSel" },
				bg = { attribute = "bg", highlight = "Normal" },
			},

			duplicate_selected = {
				fg = { attribute = "fg", highlight = "TabLineSel" },
				bg = { attribute = "bg", highlight = "TabLineSel" },
				underline = true,
			},
			duplicate_visible = {
				fg = { attribute = "fg", highlight = "TabLine" },
				bg = { attribute = "bg", highlight = "TabLine" },
				underline = true,
			},
			duplicate = {
				fg = { attribute = "fg", highlight = "TabLine" },
				bg = { attribute = "bg", highlight = "TabLine" },
				underline = true,
			},

			modified = {
				fg = { attribute = "fg", highlight = "TabLine" },
				bg = { attribute = "bg", highlight = "TabLine" },
			},
			modified_selected = {
				fg = { attribute = "fg", highlight = "Normal" },
				bg = { attribute = "bg", highlight = "Normal" },
			},
			modified_visible = {
				fg = { attribute = "fg", highlight = "TabLine" },
				bg = { attribute = "bg", highlight = "TabLine" },
			},

			separator = {
				fg = { attribute = "bg", highlight = "TabLine" },
				bg = { attribute = "bg", highlight = "TabLine" },
			},
			separator_selected = {
				fg = { attribute = "bg", highlight = "Normal" },
				bg = { attribute = "bg", highlight = "Normal" },
			},
			-- separator_visible = {
			--   fg = {attribute='bg',highlight='TabLine'},
			--   bg = {attribute='bg',highlight='TabLine'}
			--   },
			indicator_selected = {
				fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
				bg = { attribute = "bg", highlight = "Normal" },
			},
		},
	},
})
