--
--
-- local status, null_ls = pcall(require, "null-ls")
-- if not status then
-- 	return
-- end
-- local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

-- local	sources = {
-- 		null_ls.builtins.formatting.stylua,
-- 		-- null_ls.builtins.formatting.prettier,
-- 	}
-- local on_attach = function(client)
--     if client.resolved_capabilities.document_formatting then
--         vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
--    end
-- end

-- null_ls.setup({ sources = sources, on_attach = on_attach })
-- null_ls.setup(
-- 	sources = {
-- 		null_ls.builtins.formatting.stylua,
-- 		null_ls.builtins.formatting.eslint,
-- 	},
-- 	on_attach = function(client, bufnr)
-- 		if client.server_capabilities.documentFormattingProvider then
-- 			vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_format })
-- 			vim.api.nvim_create_autocmd("BufWritePre", {
-- 				group = augroup_format,
-- 				buffer = 0,
-- 				callback = function()
-- 					vim.lsp.buf.formatting({}, 1000)
-- 				end,
-- 			})
-- 		end
-- 	end,
-- })
local null_ls = require("null-ls")
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettierd,
	},
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
					-- vim.lsp.buf.format({ bufnr = bufnr })
					-- vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,
})
