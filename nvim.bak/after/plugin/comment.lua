local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

local commentstring_integration_status_ok, commentstring_integration =
	pcall(require, "ts_context_commentstring.integrations.comment_nvim")
if not commentstring_integration_status_ok then
	return
end

comment.setup({
	pre_hook = commentstring_integration.create_pre_hook(),
})
