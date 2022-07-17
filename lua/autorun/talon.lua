--
-- Talon integration with Garry's Mod
--
-- Optimal for people who do not have it: Only runs if client has talon installed! 
--
-- TODO: optimize, choose what should be replicated to the txt file (any other way without modules?)
--
-- NOTE: Client has cfg/talon.cfg IF they have talon installed. NOTHING expensive should run otherwise.
--
-- UH: If client installs talon they will execute _talon_initializer on launch to start talon expensive functions
--

if SERVER then
	AddCSLuaFile()
	CreateConVar("talonvoice_version", "0.78", FCVAR_NOTIFY)
	return
end

local THIS = 'autorun/talon.lua'
local Tag='talon'

local cfg = file.Exists("cfg/talon.cfg", 'MOD')

if not cfg then
	concommand.Add("_talon_initializer", function()
		if _G.talon then return end
		include(THIS)
		talon.init()
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

-- More expensive functions go here
talon.last_init=0
function talon.start()
	--if talon.started then return end
	talon.started = true
	if os.time()-talon.last_init>1 then
		chat.AddText("[Talon Voice] Started")
	end
	talon.last_init=os.time()
	timer.Create("talon_player_networker", 5.67, 0, talon_player_networker)
end

concommand.Add("_talon_initializer", function()
	talon.start()
end)

concommand.Add("_talon_message", function(_, _, _, msg)
	chat.AddText("[Talon] " .. tostring(msg))
end)
concommand.Add("_talon_cmd", function(_, _, _, data)
	hook.Run("talon_cmd",data)
end)
hook.Add("talon_cmd","talon_visuals",function(data)
	if data=="gmodmode 1" then
		surface.PlaySound("hl1/fvox/activated.wav")
	elseif data=="gmodmode 0" then
		surface.PlaySound("hl1/fvox/activated.wav")
	end
end)
local settings = {}

local function initSandbox()
	list.Set("TalonFeatures", "sandbox", true)
end

local function initAowl()
	local GotoLocations = {}
	local Commands = {} -- TODO?

	for k, v in pairs(aowl.GotoLocations or {}) do
		table.insert(GotoLocations, k)
	end

	local t = {
		GotoLocations = GotoLocations,
		Commands = Commands
	}

	list.Set("TalonFeatures", "aowl", t)
end
hook.Add("ShutDown",Tag,function()
	if not talon.initialized then return end
	file.Write("talonvoice/players.json", '')
	--TODO: clear settings
end)
function talon.init()
	talon.initialized = true
	talon.started = false

	if _G.aowl then
		initAowl()
	end

	if _G.ulx then
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
	local cfg = file.Exists("cfg/talon.cfg", 'MOD')

	if cfg then
		local time = file.Time("cfg/talon.cfg", 'MOD')
		local lastmod = os.time() - time

		-- autolaunch if recently used
		if lastmod < 60 * 60 * 24 * 2 then
			timer.Simple(1, talon.start)
		end
	end
end

function talon.updateFeatures(feature, val)
	if feature ~= nil then
		list.Set("TalonFeatures", feature, val)
	end

	if not talon.initialized then return end
	settings.features = list.Get("TalonFeatures")
	file.Write("talonvoice/settings.json", util.TableToJSON(settings))
end

function talon.getSettings()
	return settings
end

if util.OnInitialize then
	util.OnInitialize(function()
		talon.init()
	end)
else
	if talon.initialized then
		print("talon reinitialize")
		chat.AddText("talon reinitialize")
		talon.init()
		talon.start()
	else
		hook.Add("Initialize", Tag, talon.init)
		timer.Simple(120,function()
			if talon.initialized then return end
			talon.init()
		end)
		
	end
end