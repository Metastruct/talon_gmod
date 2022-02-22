--TODO: optimize, choose what should be replicated to the txt file

local cfg = file.Read("cfg/talon.cfg", 'MOD')
if not cfg or cfg == "" then return end

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

