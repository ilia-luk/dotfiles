local mason_nullls_status_ok, mason_nullls = pcall(require, "mason-null-ls")
if not mason_nullls_status_ok then
	return
end

mason_nullls.setup({
	ensure_installed = { "stylua", "prettierd" },
	automatic_installation = true,
	automatic_setup = true,
})

mason_nullls.setup_handlers({})

