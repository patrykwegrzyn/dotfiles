--
--
local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.formatting.prettier,
	},
	on_attach = function(client, bufnr)
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_format })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup_format,
				buffer = 0,
				callback = function()
					vim.lsp.buf.formatting_seq_sync({}, 1000)
				end,
			})
		end
	end,
})
-- local null_ls = require("null-ls")

-- null_ls.setup({
--   on_attach = function(client, bufnr)
--     local bufcmd = vim.api.nvim_buf_create_user_command

--     local format = function()
--       local params = vim.lsp.util.make_formatting_params({})
--       client.request("textDocument/formatting", params, nil, bufnr)
--     end

--     if client.server_capabilities.documentFormattingProvider then
--       bufcmd(bufnr, "NullFormat", format, { desc = "Format using null-ls" })
--     end
--   end,
--   sources = {
--     null_ls.builtins.formatting.prettier,
--   },
-- })
