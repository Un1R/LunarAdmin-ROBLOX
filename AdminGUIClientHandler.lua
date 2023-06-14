local Ex = script.Parent.Parent:WaitForChild("Execute")

local LunarRemoteEvent
local LunarRemoteFunction
for i,v in ipairs(game:GetService("ReplicatedStorage"):GetChildren()) do
	if string.sub(v.Name,string.len(v.Name),string.len(v.Name)) == "_" then
		if v:IsA("RemoteEvent") then
			LunarRemoteEvent = v
		elseif v:IsA("RemoteFunction") then
			LunarRemoteFunction = v
		end
	end
end

Ex.FocusLost:Connect(function(enter)
	if enter then
		local Split = string.split(Ex.Text," ")
		LunarRemoteEvent:FireServer("Execute",Split,Ex.Text)	
	end
end)

local UserInputService = game:GetService("UserInputService")
local val = false
UserInputService.InputBegan:Connect(function(Input,GP)
	if Input.KeyCode == Enum.KeyCode.F2 then
		if not GP and val == false then
			val = true
			for i,v in ipairs(script.Parent.Parent:GetChildren()) do
				if v:IsA("Frame") then
					game:GetService("TweenService"):Create(v,TweenInfo.new(0.43),{BackgroundTransparency = 0.67}):Play()
				elseif string.find(v.ClassName,"Text") then
					game:GetService("TweenService"):Create(v,TweenInfo.new(0.43),{BackgroundTransparency = 0.67,TextTransparency = 0}):Play()
				end
			end
			Ex:CaptureFocus()
		elseif not GP and val == true then
			val = false
			for i,v in ipairs(script.Parent.Parent:GetChildren()) do
				if v:IsA("Frame") then
					game:GetService("TweenService"):Create(v,TweenInfo.new(0.43),{BackgroundTransparency = 1}):Play()
				elseif string.find(v.ClassName,"Text") then
					game:GetService("TweenService"):Create(v,TweenInfo.new(0.43),{BackgroundTransparency = 1,TextTransparency = 1}):Play()
				end
			end
		end
	end
end)
