local module = {}
local M = require(script.Parent.Parent:WaitForChild("M"))
local Main = M.GetMain()

-- // EDIT BELOW

module.MinimumAdminLevel = "Non-Admin";
module.Arguments = {
	[1] = "Text";
}

module.Execute = function(...)
	print(table.unpack(...))
end

return module
