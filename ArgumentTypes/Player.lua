return setmetatable({
	GET = function(self,Tab)
		if typeof(Tab.Info) == "number" then
			for _,player in ipairs(game.Players:GetChildren()) do
				if player.UserId == Tab.Info then
					return player
				end
			end
			return nil
		elseif typeof(Tab.Info) == "string" then
			for _,player in ipairs(game.Players:GetChildren()) do
				if player.Name == Tab.Info then
					return player
				end
			end
			return nil
		end
		return nil
	end,
},{})
