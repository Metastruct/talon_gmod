if SERVER then AddCSLuaFile() return end

local Tag = 'talon_aowl'

local function initAowl()
	if not _G.aowl then return end
	local GotoLocations = {}
	local Commands = {} -- TODO?

	for k, v in pairs(aowl.GotoLocations or {}) do
		table.insert(GotoLocations, k)
	end

	local t = list.Get("TalonFeatures").aowl or {}
    t.GotoLocations = GotoLocations
	t.Commands = Commands
	list.Set("TalonFeatures", "aowl", t)
    if talon then
        talon.updateFeatures()
    end
end

if util.OnInitialize then
	util.OnInitialize(function()
		initAowl()
	end)
else
	if talon.initialized then
		print("talon reinitialize")
		chat.AddText("talon reinitialize")
		talon.init()
		talon.start()
	else
		hook.Add("Initialize", Tag, function()
			initAowl()
		end)
	end
end