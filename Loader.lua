local taLib = require(script:FindFirstChild("taLib"));
local NewActor = Instance.new("Actor")
NewActor.Parent = game
NewActor.Name = "LunarCore"
local Settings = require(script.Parent.Parent:WaitForChild("Settings"))
local DatastoreService = game:GetService("DataStoreService")
local Datastore = DatastoreService:GetDataStore(Settings.DatastoreName)
local Data = require(script:FindFirstChild("Types"):FindFirstChild("Data"))
local HTTPsService = game:GetService("HttpService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerStorage = game:GetService("ServerStorage");

local RemoteEvents = {
	[1] = {
		Name = HTTPsService:GenerateGUID(false).."_";
		Parent = ReplicatedStorage;
	}
};

local RemoteFunctions = {
	[1] = {
		Name = HTTPsService:GenerateGUID(false).."_";
		Parent = ReplicatedStorage;
	}
};

local Folders = {
	[1] = {
		Name = "LunarStorage";
		Parent = ServerStorage;
	},
	[2] = {
		Name = "LunarCache";
		Parent = ReplicatedStorage;
	}
}

task.spawn(function()
	for _,folder in ipairs(Folders) do
		local NL = Instance.new("Folder"); NL.Name = folder.Name ; NL.Parent = folder.Parent
	end
	for _,remoteevent in ipairs(RemoteEvents) do
		local NL = Instance.new("RemoteEvent"); NL.Name = remoteevent.Name ; NL.Parent = remoteevent.Parent
	end
	for _,remotefunction in ipairs(RemoteFunctions) do
		local NL = Instance.new("RemoteFunction"); NL.Name = remotefunction.Name ; NL.Parent = remotefunction.Parent
	end
end)
--////////////////////////////////////////////////////////////////////////--

local R1 = taLib:GetInstance(ReplicatedStorage,RemoteEvents[1].Name);
local R2 = taLib:GetInstance(ReplicatedStorage,RemoteFunctions[1].Name);
local Permissions = require(taLib:GetInstance(game:GetService("ServerScriptService"):FindFirstChild("LunarAdmin"),"Permissions"))

local TypeRequires = {
	["Parser"] = require(script:FindFirstChild("Parser"));
};
local ArgumentTypeRequires = {
	["Player"] = require(script:FindFirstChild("ArgumentTypes"):FindFirstChild("Player"));
};
local Commands = script:FindFirstChild("Commands");

local function CreatePlayerDependencies(Player)
	local Folder = Instance.new("Folder")
	Folder.Name = Player.Name
	Folder.Parent = NewActor
	
	local IntValue = Instance.new("IntValue")
	IntValue.Name = "AdminLevel"
	IntValue.Parent = Folder
end

local function GetDefaultAdminLevel(Player)
	if game.CreatorId == Player.UserId then return Settings.Levels[1].Level end
	for i,v in ipairs(Settings.Levels) do
		for x,y in ipairs(v.Usernames) do
			if y == Player.Name then
				return v.Level
			end
		end
	end
	-----
	for i,v in ipairs(Settings.Levels) do
		for x,y in ipairs(v.IDs) do
			if y == Player.UserId then
				return v.Level
			end
		end
	end
	----
	local GS = Data.GetAsync(nil,Player)
	if GS.AdminLevel then
		return GS.AdminLevel
	else
		return 0
	end
end

game.Players.PlayerAdded:Connect(function(Player)
	CreatePlayerDependencies(Player)
	local DAL = GetDefaultAdminLevel(Player)
	NewActor:FindFirstChild(Player.Name):WaitForChild("AdminLevel").Value = tonumber(DAL)
	
	pcall(function()
		if Settings.FreecamEnabled == false then
			Player:WaitForChild("PlayerGui"):FindFirstChild("Freecam"):Destroy()
		end
	end)
	
	Player.Chatted:Connect(function(Message)
		local prefix = string.sub(string.lower(Message), 1,1)
		if prefix == Settings.Prefix and Permissions.Check(Player, NewActor:FindFirstChild(Player.Name):WaitForChild("AdminLevel").Value) then
			local Command = TypeRequires["Parser"].GetCommand(Message)
			local CommandModule
			for _,command in ipairs(Commands:GetChildren()) do
				if string.lower(command.Name) == string.lower(Command) then
					CommandModule = require(command)
					break
				end
			end
			if not CommandModule then return end
			local Arguments = TypeRequires["Parser"].GetArguments(Message,#CommandModule.Arguments)
			CommandModule.Execute(Arguments)
		end
	end)
end)

game.Players.PlayerRemoving:Connect(function(Player)
	NewActor:FindFirstChild(Player.Name):Destroy()
end)

local function getargamt(...)
	local Unpack = table.pack(...)
	return #Unpack - 1
end

R1.OnServerEvent:Connect(function(Player,...)
	local Unpack = table.pack(...)
	local ArgAmt = getargamt(...)
	if (Unpack[1] ~= nil) then
		if Unpack[1] == "gs" then
			return table.clone(Settings)
		elseif Unpack[1] == "Execute" then
			local Split = Unpack[2]
			local Command = Split[1]
			local CommandModule
			for _,command in ipairs(Commands:GetChildren()) do
				if string.lower(command.Name) == string.lower(Command) then
					CommandModule = require(command)
					break
				end
			end
			if not CommandModule then return end
			local Message1 = Settings.Prefix .. Unpack[3]
			local Arguments = TypeRequires["Parser"].GetArguments(Message1,#CommandModule.Arguments)
			CommandModule.Execute(Arguments)
		end
	end
end)

--////////////////////////////////////////////////////////////////////////--
