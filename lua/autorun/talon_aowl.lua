if SERVER then
    --TODO?
    --if not file.Exists("autorun/aowl.lua",'LUA') then return end
    --AddCSLuaFile()
    return
end

local Tag = 'talon_aowl'

local function initAowl()
	if not _G.aowl then return end
	local GotoLocations = {}
	local Commands = {} -- TODO? Too dangerous likely

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
hook.Add("AowlInitialized", Tag, initAowl)
initAowl()