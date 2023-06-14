local module = {}
local M = require(script.Parent.Parent:WaitForChild("M"))
local Main = M.GetMain()

-- // EDIT BELOW

module.Arguments = {
	[1] = "Player";
}

module.Execute = function(...)
	local Player = Main.ArgumentTypes.Player:GET({Info = table.unpack(...)});
	if Player then
		print(Player.Name)
	end
end

return module
