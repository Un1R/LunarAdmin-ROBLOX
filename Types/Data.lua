local module = {}
local DatastoreService = game:GetService("DataStoreService")
local Settings = require(script.Parent.Parent.Parent.Parent:WaitForChild("Settings"))

module.SetAsync = function(Value,Player)
	if Player then
		local m
		local ds = DatastoreService:GetDataStore(Settings.DatastoreName)
		local a,b = pcall(function()
			ds:SetAsync(Settings.DatastoreKey.."/"..Player.UserId,Value)
		end)
		
		if a then
			return nil
		else
			return nil
		end
	else
		local m
		local ds = DatastoreService:GetDataStore(Settings.DatastoreName)
		local a,b = pcall(function()
			ds:SetAsync(Settings.DatastoreKey.."/".."LUNAR1",Value)
		end)

		if a then
			return nil
		else
			return nil
		end
	end
end

module.GetAsync = function(Value,Player)
	if Player then
		local m
		local ds = DatastoreService:GetDataStore(Settings.DatastoreName)
		local a,b = pcall(function()
			m = ds:GetAsync(Settings.DatastoreKey.."/"..Player.UserId)
		end)

		if a then
			return m
		else
			return nil
		end
	else
		local m
		local ds = DatastoreService:GetDataStore(Settings.DatastoreName)
		local a,b = pcall(function()
			m = ds:GetAsync(Settings.DatastoreKey.."/".."LUNAR1")
		end)

		if a then
			return m
		else
			return nil
		end
	end
end

return setmetatable(module,{})
