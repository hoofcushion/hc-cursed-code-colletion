---@generic T
---@param init fun():T
---@param set? fun(t:T)
---@return T
local function lazy(init, set)
	set = set or Util.empty_f
	local lazyt = setmetatable({}, {
		__index = function(_, k)
			local t = init()
			set(t)
			return t[k]
		end,
	})
	set(lazyt)
	return lazyt
end
local mod
mod = lazy(function()
	return { 1, 2, 3 } -- initialize the module
end, function(t)
	mod = t -- update the reference of the variable
end)
-- mod is not initialized
print(rawget(mod, 1))
-- auto initialize when index
print(mod[1])
