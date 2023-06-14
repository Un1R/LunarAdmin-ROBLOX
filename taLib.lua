-- // CREDITS TO lemonsxeed for the library
-- // Edited by Un1versality (Lunar Owner)
local module = {}
local functionForDelay = task.wait
local functionForAsync = task.spawn
function module:importVariables(tbl, delay)
	for _, v in tbl do
		for i, v2 in v[2] do
			getfenv()[i] = v[1][v2]
			if delay then
				functionForDelay(delay)
			end
		end
	end
end
function module:importVariable(var, val)
	getfenv()[var] = val
end
function module:createVariables(tbl, delay)
	for _, v in tbl do
		getfenv()[v[1]] = v[2]
		if delay then
			functionForDelay(delay)
		end
	end
end
function module:createVariable(var1, val)
	getfenv()[var1] = val
end
function module:SetVariables(tbl, delay)
	for _, v in tbl do
		v[1][v[2]] = v[3]
		if delay then
			functionForDelay(delay)
		end
	end
end
function module:SetVariable(obj, var1, val)
	obj[var1] = val
end
function module:createStatements(tbl, delay)
	for _, v in tbl do
		if v[1] then
			v[2]()
			if delay then
				functionForDelay(delay)
			end
		end
	end
end
function module:createStatement(state, func)
	return state and func()
end
function module:createForLoops(tbl, delay)
	for _, v in tbl do
		for i = v[1], v[2] do
			func(a)
			if delay then
				functionForDelay(delay)
			end
		end
	end
end
function module:createForLoop(a, b, func)
	for i = a, b do
		func(a)
	end
end
function module:callFunctions(tbl, delay)
	for _, v in tbl do
		local args = tbl
		args[1] = nil
		args = table.unpack(args)
		tbl[1](args)
		if delay then
			functionForDelay(delay)
		end
	end
end
function module:callFunction(func, ...)
	return func(...)
end
function module:createLoops(tbl, async)
	for _, v in tbl do
		if async then
			functionForAsync(
				function()
					while tbl[1] do
						tbl[2]()
					end
				end
			)
		end
	end
end
function module:createLoop(vv, vvv, async)
	if async then
		return functionForAsync(
			function()
				while vv do
					vvv()
				end
			end
		)
	end
end
function module:GetInstance(vv,vv1)
	return vv:FindFirstChild(vv1,true)
end
return setmetatable(module,{})
