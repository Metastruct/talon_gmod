if SERVER then AddCSLuaFile() return end
local Tag = 'talon_misc'

hook.Add("TalonStart",Tag,function()
	-- More expensive functions go here
	talon.last_init=talon.last_init or 0
	if os.time()-talon.last_init>1 then
		chat.AddText("[Talon Voice] Started")
		timer.Simple(2,function()
			timer.Simple(2,function()
				surface.PlaySound("vo/citadel/br_yesjudith.wav")
			end)
		end)
	end
	talon.last_init=os.time()
end)


hook.Add("talon_cmd","talon_visuals",function(data)
	if data=="gmodmode 1" then
		surface.PlaySound("hl1/fvox/activated.wav")
	elseif data=="gmodmode 0" then
		surface.PlaySound("hl1/fvox/deactivated.wav")
	end
end)

hook.Add("talon_cmd","pophiss",function(data)
	if data=="pop" then
		if hook.Run("PreTalonPop") == true then return end
		hook.Run("TalonPop")
	elseif data=="hiss" then
		if hook.Run("PreTalonHiss") == true then return end
		hook.Run("TalonHiss")
	end
end)
