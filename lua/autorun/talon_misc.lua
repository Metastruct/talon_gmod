if SERVER then
	AddCSLuaFile()

	return
end

local Tag = 'talon_misc'

hook.Add("TalonStart", Tag, function()
	-- More expensive functions go here
	talon.last_init = talon.last_init or 0

	if os.time() - talon.last_init > 1 then
		chat.AddText("[Talon Voice] Started")

		timer.Simple(2, function()
			timer.Simple(2, function()
				surface.PlaySound("vo/citadel/br_yesjudith.wav")
			end)
		end)
	end

	talon.last_init = os.time()
end)

local talon_gmodmode_sound = CreateClientConVar("talon_gmodmode_sound",'1')
hook.Add("TalonCommand", "talon_gmodmode_sound", function(data)
	if not talon_gmodmode_sound:GetBool() then return end
	if data == "gmodmode 1" then
		surface.PlaySound("hl1/fvox/activated.wav")
	elseif data == "gmodmode 0" then
		surface.PlaySound("hl1/fvox/deactivated.wav")
	end
end)

hook.Add("TalonCommand", "pophiss", function(data)
	if data == "pop" then
		if hook.Run("PreTalonPop") == true then return end
		return hook.Run("TalonPop")
	elseif data == "hiss 1" then
		if hook.Run("PreTalonHiss", true) == true then return end
		return hook.Run("TalonHiss", true)
	elseif data == "hiss 0" then
		if hook.Run("PreTalonHiss", false) == true then return end
		return hook.Run("TalonHiss", false)
	end
end)

-- +attack on hiss/pop
local enable_hiss_attack

hook.Add("TalonCommand", "attack_hiss_pop", function(data)
	if data == "attackhisspop 1" then
		enable_hiss_attack = true
		return true
	elseif data == "attackhisspop 0" then
		enable_hiss_attack = false
		return true
	end
end)

hook.Add("TalonCommand", "properties", function(data)
	local property = data:match("^properties ([a-zA-Z0-9%_%.%-]+)")
	if not property or not properties then return end
	local prop = properties.List[property]
	if not prop then return end
	local ent = LocalPlayer():GetEyeTrace().Entity
	if not ent:IsValid() then return end
	print("[Talon] Running property",property,"on",ent)
	prop:Action(ent,LocalPlayer():GetEyeTrace())
end)

hook.Add("TalonHiss", Tag, function(attacking)
	if not enable_hiss_attack then return end

	if attacking then
		RunConsoleCommand("+attack")
	else
		RunConsoleCommand("-attack")
	end

	return true
end)

hook.Add("TalonPop", Tag, function()
	if not enable_hiss_attack then return end
	RunConsoleCommand("+attack")

	timer.Simple(0.01, function()
		RunConsoleCommand("-attack")
	end)

	return true
end)