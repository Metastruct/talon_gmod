app: gmod
and tag: user.gmodmode
-

# Demo python commands
^computer what time is it$: user.gmod_timefi()
^computer what is the time$: user.gmod_timefi()
^computer time please$: user.gmod_timefi()
^computer current time please$: user.gmod_timefi()

# Generic GMod commands
toggle flashlight: user.gmod_runcmd("impulse 100")
flashlight: user.gmod_runcmd("impulse 100")
flash light: user.gmod_runcmd("impulse 100")

toggle noclip: user.gmod_runcmd("noclip")
wingardium leviosaa: user.gmod_runcmd("noclip")
wingardium leviosa: user.gmod_runcmd("noclip")
siipiirdium lentiusa: user.gmod_runcmd("noclip")

^(operator|computer) terminate user$: user.gmod_runcmd("kill")
# Somehow this command always gets triggered so we disable it
^i cant take this anymore$: user.gmod_runcmd("echo do it yourself")

#SECURITY: Pay attention to potential command injections!!!
^(microphone enable|enable microphone|enable micro phone|micro phone enable)$: user.gmod_runcmd("+voicerecord")
^(microphone disable|disable microphone|disable micro phone|micro phone disable)$: user.gmod_runcmd("-voicerecord")

^computer stop sounds$: user.gmod_runcmd("stopsound")
^computer set [game] volume to <number>$: 
	user.gmod_runcmd("volume {number/100}")
	user.gmod_runcmd("play hl1/fvox/fuzz.wav")

^computer mute game$: 
	user.gmod_runcmd("volume 0")

# TODO: old volume
^computer unmute game$: 
	user.gmod_runcmd("volume 0.5")
	user.gmod_runcmd("hl1/fvox/fuzz.wav")

^computer (mute players|set player volume to zero)$: user.gmod_runcmd("voice_scale 0")

# Demo sandbox commands, always active
^operator I need a shotgun$: user.gmod_runcmd("gm_giveswep weapon_shotgun")
^operator give this person a shotgun$: user.gmod_runcmd("gm_giveswep weapon_shotgun")
^operator give us shotguns$:
	user.gmod_runcmd("gm_giveswep weapon_shotgun")
	user.gmod_runcmd("gm_spawnswep weapon_shotgun")

^operator I need a (vehicle|jeep)$: user.gmod_runcmd("gm_spawnvehicle Jeep")
^operator (I need a means of transportation|we need a jeep)$: user.gmod_runcmd("gm_spawnvehicle Jeep")

# Base GMod weapons selection
^(select|use) (weapon|wepon) {user.gmod_baseweapons}$: 
    user.gmod_runcmd("use "+user.gmod_baseweapons)

# VRMod (TODO: tag, etc)
^exit vr mod confirm$: user.gmod_runcmd("vrmod_exit")
^(computer start vr|computer start vr mode)$: user.gmod_preparecmd("vrmod_start")

computer (commence|initialize|prepare|engage) self (destruct|destruction): 
	user.gmod_runcmd("_talon_message Confirmation required")
	user.gmod_preparecmd("kill")
computer cancel (command|order): 
	user.gmod_runcmd("")
	user.gmod_preparecmd("")