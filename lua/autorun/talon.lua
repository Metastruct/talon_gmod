--
-- Talon integration with Garry's Mod
--
-- Optimized for people who do not have it: Only runs expensive code if client has talon installed! 
-- TODO: Optimize further, choose what should be replicated to the json files (any other way without modules?)
-- NOTE: Client has cfg/talon.cfg IF they have talon installed. NOTHING expensive should run otherwise.
--
-- UH: If client installs talon they will execute _talon_initializer on launch to start talon expensive functions
--
--
--
-- 
--


local talonver="0.78"
if SERVER then
	AddCSLuaFile()
	CreateConVar("talonvoice_version", talonver, FCVAR_NOTIFY)
	return
end

local THIS = 'autorun/talon.lua'
local Tag='talon'

local cfg = file.Exists("cfg/talon.cfg", 'MOD')

if not cfg then
	concommand.Add("_talon_initializer", function()
		if _G.talon then return end
		include(THIS)
		talon.onInitialize()
	end)

	return
end

local talon = _G.talon or {}
_G.talon = talon


local function UndecorateNick_Fallback(nick)
	-- TODO
	return nil, nil, nick
end

file.CreateDir("talonvoice")
local last = ""

local function talon_player_networker()
	local t = hook.Run("TalonTeleportListThink")
	if t and not istable(t) then t=nil end
	
	if not t then
		local UndecorateNick = UndecorateNick or UndecorateNick_Fallback
		t = player.GetHumans()

		for k, v in next, t do
			local nick = select(3, UndecorateNick(v:Nick()))
			nick = nick:gsub("[^a-zA-Z ]", " "):gsub("  ", " "):gsub("  ", " "):Trim() -- TODO: convert to words
			t[k] = v:SteamID() .. ' ' .. nick
		end
	end

	t = table.concat(t, "\n")

	if last ~= t then
		file.Write("talonvoice/players.json", t)
		last = t
	end
end

-- Start the Garry's Mod talon side. Otherwise only minimal functionality is enabled.
function talon.start()
	--if talon.started then return end
	talon.started = true
	timer.Create("talon_player_networker", 5.67, 0, talon_player_networker)
	hook.Run("TalonStart")
end

-- Called from talon to signal that talon is activated
concommand.Add("_talon_initializer", function()
	talon.start()
end)

-- Called from talon to print a message
concommand.Add("_talon_message", function(_, _, _, msg)
	chat.AddText("[Talon] " .. tostring(msg))
end)

-- Generic CMD dispatcher from talon
concommand.Add("_talon_cmd", function(_, _, _, data)
	hook.Run("talon_cmd",data)
end)


local settings = {}

local function initFeature(name)
	local t = list.Get("TalonFeatures")[name] or {}
	list.Set("TalonFeatures", name, t)
	return t
end

local function initSandbox()
	initFeature "sandbox"
end

hook.Add("ShutDown",Tag,function()
	if not talon.initialized then return end
	file.Write("talonvoice/players.json", '')
	--TODO: clear settings
end)

-- populate generic settings for talon side to make use of
local function populateSettings(settings)
	settings.ActiveGamemode = engine.ActiveGamemode()
	settings.IPAddress = game.GetIPAddress()
	settings.HostName = GetHostName()
	settings.Map = game.GetMap()
	settings.ts = os.time()
	settings.ct = CurTime()
	settings.tss = system.SteamTime()

	local weps = {}

	for k, v in pairs(weapons.GetList()) do
		if v.Spawnable then
			weps[v.ClassName] = (language.GetPhrase(v.PrintName or "") or ""):gsub("[^a-zA-Z ]", "")
		end
	end

	settings.weapons = weps
end

-- Initializes talon
function talon.onInitialize()
	talon.initialized = true
	talon.started = false


	if _G.ulx then
		initFeature "ulx"
	end

	if GAMEMODE and GAMEMODE.IsSandboxDerived then
		initSandbox()
	end

	if weapons.Get("arcticvr_m9") then
		initFeature "arcvr"
	end

	populateSettings(settings)
	hook.Run("TalonRequestSettings", settings)

	talon.updateFeatures()
	local cfg = file.Exists("cfg/talon.cfg", 'MOD')

	if cfg then
		local time = file.Time("cfg/talon.cfg", 'MOD')
		local lastmod = os.time() - time

		-- autolaunch if used during last two days
		if lastmod < 60 * 60 * 24 * 2 then
			timer.Simple(1, talon.start)
		end
	end
end

-- Call updateFeatures() when you change the list.Set("TalonFeatures", "featurename", {}) table or contents
function talon.updateFeatures(feature, val)
	if feature ~= nil then
		list.Set("TalonFeatures", feature, val)
	end

	if not talon.initialized then return end
	settings.features = list.Get("TalonFeatures")
	settings.ver = talonver
	file.Write("talonvoice/settings.json", util.TableToJSON(settings))
end

-- Returns gtalon internal settings. 
-- You can update this table in-place and call updateFeatures().
function talon.getSettings()
	return settings
end

-- Initialization --

if util.OnInitialize then
	util.OnInitialize(function()
		talon.onInitialize()
	end)
else
	if talon.initialized then
		print("talon reinitialize")
		chat.AddText("talon reinitialize")
		talon.onInitialize()
		talon.start()
	else
		hook.Add("Initialize", Tag, talon.init)
		timer.Simple(120,function()
			if talon.initialized then return end
			talon.onInitialize()
		end)
		
	end
end