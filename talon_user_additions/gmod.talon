app: gmod
and tag: user.gmodmode
-

# Demo sandbox commands, always active
^(computer what time is it|computer what is the time|computer time please|computer current time please)$: user.gmod_timefi()
^operator I need a shotgun$: user.gmod_runcmd("gm_giveswep weapon_shotgun")
^operator give this person a shotgun$: user.gmod_runcmd("gm_giveswep weapon_shotgun")
^operator give us shotguns$:
	user.gmod_runcmd("gm_giveswep weapon_shotgun")
	user.gmod_runcmd("gm_spawnswep weapon_shotgun")
^operator I need a (vehicle|jeep)$: user.gmod_runcmd("gm_spawnvehicle Jeep")
^operator (I need a means of transportation|we need a jeep)$: user.gmod_runcmd("gm_spawnvehicle Jeep")

# Misc commands
toggle noclip: user.gmod_runcmd("noclip")

# Suicide
^(operator|computer) terminate user$: user.gmod_runcmd("kill")

# Audio volume and microphone 

#SECURITY: Pay attention to potential command injections!!!
^(microphone enable|enable microphone|enable micro phone|micro phone enable)$: user.gmod_runcmd("+voicerecord")
^(microphone disable|disable microphone|disable micro phone|micro phone disable)$: user.gmod_runcmd("-voicerecord")

^[computer] stop sounds|shutdown all the sounds$: user.gmod_runcmd("stopsound;play garrysmod/ui_click.wav")
^computer set [game] volume to <number>$: user.gmod_runcmd("play hl1/fvox/fuzz.wav;volume {number/100}")

^computer mute game$: user.gmod_runcmd("volume 0")
^computer unmute game$: user.gmod_runcmd("volume 0.7;play hl1/fvox/fuzz.wav")
^computer (mute players|set player volume to zero)$: user.gmod_runcmd("voice_scale 0;play garrysmod/content_downloaded.wav")
^computer (unmute players|set player volume to <number>)$: user.gmod_runcmd("voice_scale {number/100};play garrysmod/ui_click.wav")

# Base GMod weapons selection
^(select|use) (weapon|wepon) {user.gmod_baseweapons}$: user.gmod_runcmd("use "+user.gmod_baseweapons)

^[computer] (commence|initialize|prepare|engage) self (destruct|destruction)$: 
	user.gmod_runcmd("_talon_message Confirmation required! Say execute to proceed.")
	user.gmod_runcmd("play hl1/fvox/near_death.wav")
	user.gmod_preparecmd("kill")
[computer] cancel (command|order): 
	user.gmod_runcmd("play garrysmod/ui_return.wav")
	user.gmod_preparecmd("")

# Hiss pop attack system
^enable attack on pop$: user.gmod_runcmd("_talon_cmd attackhisspop 1;play weapons/357/357_reload4.wav")
^disable attack on pop$: user.gmod_runcmd("_talon_cmd attackhisspop 0;play weapons/357/357_reload4.wav")

# Somehow these commands always gets triggered
^i cant take this anymore$: user.gmod_preparecmd("kill")
