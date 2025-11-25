local function utf8_sub(str, start, finish)
	return table.concat(vim.list_slice(vim.tbl_map(vim.fn.nr2char, vim.fn.str2list(str)), start, finish))
end
print(utf8_sub("你好，世界！",4,5))
