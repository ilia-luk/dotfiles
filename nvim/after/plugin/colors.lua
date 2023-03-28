function ColorMyPencils(color)
	color = color or "onedark"
	vim.cmd.colorscheme(color)
	vim.cmd("hi CursorLine cterm=NONE guibg=#601d74")
end

ColorMyPencils()
