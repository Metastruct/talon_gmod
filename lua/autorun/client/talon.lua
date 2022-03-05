--
-- Clientside part of talon for better integration with Garry's Mod
--
-- Very WIP, help wanted
--

--TODO: optimize, choose what should be replicated to the txt file
local cfg = file.Read("cfg/talon.cfg", 'MOD')
if not cfg or cfg == "" then return end
local talon = _G.talon or {}
_G.talon = talon

local function UndecorateNick_Fallback(nick)
	-- TODO
	return nil, nil, nick
end

file.CreateDir("talonvoice")
local last = ""

timer.Create("talon_player_networker", 5.67, 0, function()
	local UndecorateNick = UndecorateNick or UndecorateNick_Fallback
	local t = player.GetHumans()

	for k, v in next, t do
		t[k] = v:EntIndex() .. ' ' .. select(3, UndecorateNick(v:Nick()))
	end

	t = table.concat(t, "\n")

	if last ~= t then
		file.Write("talonvoice/players.json", t)
		last = t
	end
end)

local settings = {}

local function initSandbox()
	list.Set("TalonFeatures", "sandbox", true)
end

local function initAowl()
	local GotoLocations = {}

	for k, v in pairs(aowl.GotoLocations or {}) do
		table.insert(GotoLocations, k)
	end

	local t = {
		GotoLocations = GotoLocations
	}

	list.Set("TalonFeatures", "aowl", t)
end

local function init()
	if aowl then 
		initAowl()
	end

	if ulx then
		list.Set("TalonFeatures", "ulx", true)
	end

	if GAMEMODE and GAMEMODE.IsSandboxDerived then
		initSandbox()
	end

	if weapons.Get("arcticvr_m9") then
		list.Set("TalonFeatures", "arcvr", true)
	end

	settings.ActiveGamemode = engine.ActiveGamemode()
	settings.IPAddress = game.GetIPAddress()
	settings.HostName = GetHostName()
	settings.Map = game.GetMap()
	local weps = {}

	for k, v in pairs(weapons.GetList()) do
		if v.Spawnable then
			weps[v.ClassName] = (language.GetPhrase(v.PrintName or "") or ""):gsub("[^a-zA-Z ]", "")
		end
	end

	settings.weapons = weps
	hook.Run("TalonRequestSettings", settings)
	talon.updateFeatures()
end

function talon.updateFeatures(feature, val)
	if feature ~= nil then
		list.Set("TalonFeatures", feature, val)
	end

	settings.features = list.Get("TalonFeatures")
	file.Write("talonvoice/settings.json", util.TableToJSON(settings))
	PrintTable(settings)
end

function talon.getSettings()
	return settings
end

if util.OnInitialize then
	util.OnInitialize(init)
else
	hook.Add("Initialize", "talon", init)
end