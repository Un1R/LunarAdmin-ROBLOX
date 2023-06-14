local module = {}
local Settings = require(script.Parent.Parent.Parent.Parent:WaitForChild("Settings"));

module.StringToLevel = function(str)
	for i,v in ipairs(Settings.Levels) do
		if v.Name == str then
			return v.Level
		end
	end
	return 0
end

module.Check = function(Player, Required)
	local Acotr = game:FindFirstChild("LunarCore")
	if typeof(Required) == "string" then
		if Acotr:FindFirstChild(Player.Name) then
			if Acotr:FindFirstChild(Player.Name):WaitForChild("AdminLevel").Value >= module.StringToLevel(Required) then
				return true
			end
		end
	elseif typeof(Required) == "number" then
		if Acotr:FindFirstChild(Player.Name) then
			if Acotr:FindFirstChild(Player.Name):WaitForChild("AdminLevel").Value >= Required then
				return true
			end
		end
	end
	return false
end

return setmetatable(module,{})
