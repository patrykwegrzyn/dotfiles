local colors = {
	fg = "#ABB2BF",
	red = "#E06C75",
	orange = "#FF8700",
	yellow = "#E5C07B",
	green = "#afd700",
	cyan = "#56B6C2",
	blue = "#61AFEF",
	violet = "#CBA6F7",
	teal = "#1abc9c",
}

local kind = {
	[1] = { "File", " ", colors.fg },
	[2] = { "Module", " ", colors.blue },
	[3] = { "Namespace", " ", colors.orange },
	[4] = { "Package", " ", colors.violet },
	[5] = { "Class", " ", colors.violet },
	[6] = { "Method", " ", colors.violet },
	[7] = { "Property", " ", colors.cyan },
	[8] = { "Field", " ", colors.teal },
	[9] = { "Constructor", " ", colors.blue },
	[10] = { "Enum", "了", colors.green },
	[11] = { "Interface", " ", colors.orange },
	[12] = { "Function", " ", colors.blue },
	[13] = { "Variable", " ", colors.yellow },
	[14] = { "Constant", " ", colors.fg },
	[15] = { "String", " ", colors.green },
	[16] = { "Number", " ", colors.green },
	[17] = { "Boolean", " ", colors.orange },
	[18] = { "Array", " ", colors.blue },
	[19] = { "Object", " ", colors.orange },
	[20] = { "Key", " ", colors.red },
	[21] = { "Null", " ", colors.red },
	[22] = { "EnumMember", " ", colors.green },
	[23] = { "Struct", " ", colors.violet },
	[24] = { "Event", " ", colors.violet },
	[25] = { "Operator", " ", colors.green },
	[26] = { "TypeParameter", " ", colors.green },
	-- ccls
	[252] = { "TypeAlias", " ", colors.green },
	[253] = { "Parameter", " ", colors.blue },
	[254] = { "StaticMethod", "ﴂ ", colors.orange },
	[255] = { "Macro", " ", colors.red },
}
local hi_prefix = "LSOutline2"
local function gen_outline_hi()
	for _, v in pairs(kind) do
		vim.api.nvim_set_hl(0, hi_prefix .. v[1], { fg = v[3] })
	end
end

local current_bufnr
local code_win
local maxDepth = 0

local bufnr = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_option(bufnr, "filetype", "Outline")
vim.api.nvim_buf_set_name(bufnr, "Outline")
-- vim.api.nvim_buf_set_option(bufnr, "bufhidden", "delete")

vim.api.nvim_command("botright vs")
vim.cmd("vertical resize " .. 20)

local winnr = vim.api.nvim_get_current_win()
vim.api.nvim_win_set_buf(winnr, bufnr)
vim.api.nvim_win_set_option(winnr, "number", false)
vim.api.nvim_win_set_option(winnr, "relativenumber", false)
vim.api.nvim_win_set_option(winnr, "winfixwidth", true)
vim.api.nvim_win_set_option(winnr, "list", false)

vim.keymap.set("n", "o", function()
	local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
	local text = vim.api.nvim_buf_get_text(bufnr, current_line, 0, current_line, -1, {})
	words = {}
	for word in text[1]:gmatch("%w+") do
		table.insert(words, tonumber(word))
	end
	-- vim.api.nvim_set_current_win(code_win)
	vim.api.nvim_win_set_cursor(code_win, { words[1], words[2] })
end, {
	buffer = bufnr,
})

vim.keymap.set("n", "oo", function()
	local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
	local text = vim.api.nvim_buf_get_text(bufnr, current_line, 0, current_line, -1, {})
	words = {}
	for word in text[1]:gmatch("%w+") do
		table.insert(words, tonumber(word))
	end
	vim.api.nvim_set_current_win(code_win)
	vim.api.nvim_win_set_cursor(code_win, { words[1], words[2] })
end, {
	buffer = bufnr,
})
print("init" .. bufnr .. " " .. winnr)
local method = "textDocument/documentSymbol"

function rpairs(t)
	return function(t, i)
		i = i - 1
		if i ~= 0 then
			return i, t[i]
		end
	end, t, #t + 1
end

function sortNodes(nodes)
	table.sort(nodes, function(a, b)
		return a.range.start.line > b.range.start.line
	end)
end

local function parse_nodes(tbl, nodes, depth)
	depth = depth or 0
	sortNodes(tbl)
	for _, node in rpairs(tbl) do
		table.insert(nodes, {
			name = node.name:gsub("callback", "cb"),
			range = node.range,
			kind = kind[node.kind],
			depth = depth,
		})
		print(vim.inspect(node))
		nextDepth = depth + 1
		if node.children ~= nil and next(node.children) ~= nill and nextDepth <= maxDepth then
			parse_nodes(node.children, nodes, nextDepth)
		end
	end
end

local function getSymbols(bufnr, callback)
	local params = { textDocument = vim.lsp.util.make_text_document_params(current_bufnr) }
	local clients = vim.lsp.buf_get_clients()

	local client
	for _, instance in pairs(clients) do
		if instance.server_capabilities["documentSymbolProvider"] then
			-- print("ok dsp")
			client = instance
		end
	end
	if not client then
		print("[Lspsaga] Server of this buffer not support " .. method)
		return callback(nil)
	end
	client.request(method, params, function(_, result)
		if not result or next(result) == nil then
			return callback(nill)
		end
		return callback(result)
	end, current_bufnr)
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter", "BufWrite" }, {
	pattern = "*",
	callback = function()
		win = vim.api.nvim_get_current_win()
		buf = vim.api.nvim_get_current_buf()
		if win ~= winnr then
			code_win = win
		end
		if bufnr ~= buf then
			current_bufnr = buf
			-- print("winnr:" .. winnr .. " " .. "bufnr:" .. bufnr .. " " .. "current_bufnr:" .. current_bufnr)
			local nodes = {}
			gen_outline_hi()
			-- print("callback" .. bufnr .. " " .. winnr)
			getSymbols(bufnr, function(symbols)
				if symbols ~= nil then
					parse_nodes(symbols, nodes)
					local lines = {}
					for i, node in ipairs(nodes) do
						-- print(vim.inspect(node))
						local start = node.range.start.line + 1
						local ch = node.range.start.character
						local line = string.rep("  ", node.depth)
							.. node.kind[2]
							.. node.name
							.. " "
							.. "("
							.. start
							.. ","
							.. ch
							.. ")"
						table.insert(lines, line)
						-- vim.api.nvim_buf_add_highlight(bufnr, 0, hi_prefix .. node.kind[1], i - 1, 0, -1)
					end
					vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
					vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
					for i, node in ipairs(nodes) do
						vim.api.nvim_buf_add_highlight(bufnr, 0, hi_prefix .. node.kind[1], i - 1, 0, -1)
					end
					vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
					nodes = {}
					lines = {}
				end
			end)
		end
	end,
})
