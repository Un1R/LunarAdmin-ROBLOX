local settings = {}

--// CORE
settings.Prefix = ";";
settings.InPrivateServer = true;
settings.FreecamEnabled = true;

--// DATA
settings.DatastoreName = "Lunar_1";
settings.DatastoreKey = "Lunar_1Key";

--// PERMISSIONS
settings.Levels = {
	[1] = {
		["Name"] = "Creator";
		["Level"] = 1000;
		["IDs"] = {1}; -- Seperated By Commas {1,2,3}
		["Usernames"] = {"ROBLOX"}; -- Seperated By Commas {"ROBLOX","Builderman","Jack"}
	};
	
	[2] = {
		["Name"] = "Head Admin";
		["Level"] = 700;
		["IDs"] = {1}; -- Seperated By Commas {1,2,3}
		["Usernames"] = {"ROBLOX"}; -- Seperated By Commas {"ROBLOX","Builderman","Jack"}
	};
	
	[3] = {
		["Name"] = "Admin";
		["Level"] = 400;
		["IDs"] = {1}; -- Seperated By Commas {1,2,3}
		["Usernames"] = {"ROBLOX"}; -- Seperated By Commas {"ROBLOX","Builderman","Jack"}
	};
	
	[4] = {
		["Name"] = "Moderator";
		["Level"] = 100;
		["IDs"] = {1}; -- Seperated By Commas {1,2,3}
		["Usernames"] = {"ROBLOX"} -- Seperated By Commas {"ROBLOX","Builderman","Jack"}
	};
	
	[5] = {
		["Name"] = "Non-Admin";
		["Level"] = 0;
		["IDs"] = {1}; -- Seperated By Commas {1,2,3}
		["Usernames"] = {"ROBLOX"} -- Seperated By Commas {"ROBLOX","Builderman","Jack"}
	}
};

settings.PrivateServerOwnerHasAdmin = false;
settings.PrivateServerAdminLevel = "Admin";


return setmetatable(settings,{
	__call = function()
		local RunService = game:GetService("RunService");
		if RunService:IsClient() then return {} end
	end,
})
