local module = {}
local ArgumentTypes = script.Parent:WaitForChild("ArgumentTypes")

module.GetMain = function()
	return {
		Parser = require(script.Parent:FindFirstChild("Parser"));
		taLib = require(script.Parent:FindFirstChild("taLib"));
		ArgumentTypes = {
			Player = require(ArgumentTypes:WaitForChild("Player"));
		}
	}
end

return setmetatable(module,{})
