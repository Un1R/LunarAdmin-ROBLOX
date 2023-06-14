local module = {}
local Settings = require(script.Parent.Parent.Parent:WaitForChild("Settings"));
module.CheckPrefix = function(first)
	if string.find(first,Settings.Prefix) then
		return true
	else
		return false
	end
end
module.GetCommand = function(str)
	local split = string.split(str," ")
	local command = split[1]
	if command then
		local newcommand = string.gsub(command,Settings.Prefix,"")
		return newcommand
	end
	return nil
end
module.GetArguments = function(str,amt)
	local split = string.split(str," ")
	table.remove(split,1)
	
	local Args = {}
	for i,v in ipairs(split) do
		if i <= amt then
			table.insert(Args,v)
		else
			break
		end
	end
	
	if #Args ~= #split then
		for _,y in ipairs(split) do
			if _ > #Args then
				Args[#Args] = Args[#Args] .. split[_]
			end
		end
	end
	
	return Args
end
return setmetatable(module,{})
