local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end
-- local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.eslint,
	},
	on_attach = function(client, bufnr)
		print(client.name)
		print(client.supports_method("textDocument/formatting"))
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
					-- vim.lsp.buf.formatting_seq_sync()
				end,
			})
		end
	end,
	-- on_attach = function(client, bufnr)
	-- 	if client.server_capabilities.documentFormattingProvider then
	-- 		vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_format })
	-- 		vim.api.nvim_create_autocmd("BufWritePre", {
	-- 			group = augroup_format,
	-- 			buffer = 0,
	-- 			callback = function()
	-- 				vim.lsp.buf.formatting_seq_sync({}, 3000)
	-- 			end,
	-- 		})
	-- 	end
	-- end,
})
